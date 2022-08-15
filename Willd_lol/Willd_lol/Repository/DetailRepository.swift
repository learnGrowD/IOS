//
//  DetailRepository.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/09.
//

import Foundation
import RxSwift
import RxCocoa

struct ChampionSkinInfo : Codable {
    let championIdentity : String?
    let skinName : String?
    let skinIdentity : Int
}


typealias ChampionUserComment = (comment : [ChampionCommentApi.Comment], commentCount : Int)
enum ChampionDetailPageDataModel {
    case skins(_ title : String?, _ data : [ChampionSkinInfo])
    case tags(_ title : String?, _ data : [String])
    case skills(_ title : String?, _ data : [ChampionListApi.Champion.Skill])
    case lore(_ title : String?, _ data : String)
    case playerLank(_ title : String?, _ data : [ChampionGoodAtPlayerApi.Player])
    case championComment(_ title : String?, _ data : (commentCount : Int, comment : [ChampionCommentApi.Comment]))
}

protocol DetailRepositoryProtocal {
//    func searchDetailData() -> PublishSubject<UiState<SearchDetailPageData>>
//    func championDetailData(champion : Observable<Champion>) -> Observable<[ChampionDetailPageSectionType]>
//    func playerDetailData() -> PublishSubject<UiState<PlayerDetailPageData>>
//    func rankDetailData() -> PublishSubject<UiState<RankDetailPageData>>
}

class DetailRepository {
    static let instance = DetailRepository()
    private let apiService : ApiService
    private let disposeBag = DisposeBag()
    private init() {
        apiService = ApiService.instance
    }
    
    func getSkins(champion : Observable<Champion>) -> Observable<[ChampionSkinInfo]> {
        let championDetailResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championDetail(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()
        
        
        let skins = championDetailResult
            .map { result -> [ChampionDetailApi.Data.Champion.Skin] in
                guard case .success(let api) = result else {
                    return []
                }
                return api.data.champion.skins.sorted {
                    $0.num ?? 0 > $1.num ?? 0
                }
            }
        
        let skinNums = skins
            .map {
                $0.map {
                    $0.num ?? 0
                }
            }
        
        let skinNames = skins
            .map {
                $0.map {
                    $0.name
                }
            }
        
        return Observable
            .combineLatest(
                skinNums,
                skinNames,
                champion) { a, b, c -> [ChampionSkinInfo] in
                    let skins = a
                    .enumerated()
                    .map { index, element -> ChampionSkinInfo in
                        if b[index] == "default" {
                            return ChampionSkinInfo(championIdentity : c.key, skinName : c.name  ,skinIdentity : element)
                        } else {
                            return ChampionSkinInfo(championIdentity : c.key, skinName : b[index]  ,skinIdentity : element)
                        }
                        
                    }
                    return skins
            }
    }
    
    func getTags(champion : Observable<Champion>) -> Observable<[String]>{
        let championDetailResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championDetail(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()
        
        let tags = championDetailResult
            .map { result -> [String] in
                guard case .success(let api) = result else {
                    return []
                }
                var tags = api.data.champion.tags
                tags.insert(api.data.champion.title ?? "", at: 0)
                return tags
            }
        return tags
    }
    
    func getSkills(champion : Observable<Champion>) -> Observable<[ChampionListApi.Champion.Skill]> {
        return champion
            .map { result -> [ChampionListApi.Champion.Skill] in
                var spells = result.spells
                spells.insert(result.passive, at: 0)
                return spells
            }
    }
    
    func getLore(champion : Observable<Champion>) -> Observable<String> {
        let championDetailResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championDetail(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()
        
        return championDetailResult
            .map { result -> String in
                guard case .success(let api) = result else {
                    return ""
                }
                return api.data.champion.lore ?? ""
            }
    }
    
    func getPlayerLank(champion : Observable<Champion>) -> Observable<[ChampionGoodAtPlayerApi.Player]> {
        let playerLankResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championGoodAtPlayerRank(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()
        
        return playerLankResult
            .map { result -> [ChampionGoodAtPlayerApi.Player] in
                guard case .success(let api) = result else {
                    return []
                }
                return api.data
            }
    }
    
    func getComment(champion : Observable<Champion> ) -> Observable<[ChampionCommentApi.Comment]> {
        let championCommentResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championComment(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()
        return championCommentResult
            .map { result -> [ChampionCommentApi.Comment] in
                guard case .success(let api) = result else {
                    return []
                }
                return api.data.sorted {
                    $0.vote ?? 0 > $1.vote ?? 0
                }
            }
    }
    
    func getCommentCount(champion : Observable<Champion>) -> Observable<Int> {
        let championCommentCountResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championCommentCount(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()
        return championCommentCountResult
            .map { result -> Int in
                guard case .success(let api) = result else {
                    return 0
                }
                return api.data.count ?? 0
            }
    }
    
}


