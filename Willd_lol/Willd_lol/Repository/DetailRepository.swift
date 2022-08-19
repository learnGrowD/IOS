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
    func getSkins(champion : Champion) -> Observable<[ChampionSkinInfo]>
    func getSkins(championKey : String, championName : String) -> Observable<[ChampionSkinInfo]>
    
    func getTags() -> Observable<[String]>

    func getSkills(champion : Observable<Champion>) -> Observable<[ChampionListApi.Champion.Skill]>
    func getSkills(championInfo : Observable<(spells : [ChampionListApi.Champion.Skill], passive : ChampionListApi.Champion.Skill)>) -> Observable<[ChampionListApi.Champion.Skill]>
    
    func getLore() -> Observable<String>
    
    func getPlayerLank(champion : Observable<Champion>) -> Observable<[ChampionGoodAtPlayerApi.Player]>
    func getPlayerLank(championKey : Observable<String>) -> Observable<[ChampionGoodAtPlayerApi.Player]>
    
    func getComment(champion : Observable<Champion> ) -> Observable<[ChampionCommentApi.Comment]>
    func getComment(championKey : Observable<String> ) -> Observable<[ChampionCommentApi.Comment]>
    
    func getCommentCount(champion : Observable<Champion>) -> Observable<Int>
    func getCommentCount(championKey : Observable<String>) -> Observable<Int>
}

class DetailRepository : DetailRepositoryProtocal {
    
//    static let instance = DetailRepository()
    private let apiService : ApiService = ApiService.instance
    private let disposeBag = DisposeBag()
    private let championDetailResult : Observable<ChampionDetailApi?>
    
    init(champion : Champion) {
        championDetailResult = apiService.championDetail(championKey: champion.key)
            .map { result -> ChampionDetailApi? in
                guard case .success(let api) = result else {
                    return nil
                }
                return api
            }
            .asObservable()
    }
    
    init(championKey : String) {
        championDetailResult = apiService.championDetail(championKey: championKey)
            .map { result -> ChampionDetailApi? in
                guard case .success(let api) = result else {
                    return nil
                }
                return api
            }
            .asObservable()
    }
    
    func getSkins(champion : Champion) -> Observable<[ChampionSkinInfo]> {
        let skins = self.championDetailResult
            .map { api -> [ChampionDetailApi.Data.Champion.Skin] in
                guard let api = api else {
                    return []
                }
                return api.data.champion.skins.sorted {
                    $0.num ?? 0 > $1.num ?? 0
                }
            }
        return Observable
            .combineLatest(
                Observable.just(champion),
                skins) { champion, skins in
                    skins.map { skin in
                        if skin.name == "default" {
                            return ChampionSkinInfo(championIdentity : champion.key, skinName : champion.name, skinIdentity : skin.num ?? 0)
                        }else {
                            return ChampionSkinInfo(championIdentity : champion.key, skinName : skin.name, skinIdentity : skin.num ?? 0)
                        }
                    }
                }
    }
    
    func getSkins(championKey : String, championName : String) -> Observable<[ChampionSkinInfo]> {
        let skins = self.championDetailResult
            .map { api -> [ChampionDetailApi.Data.Champion.Skin] in
                guard let api = api else {
                    return []
                }
                return api.data.champion.skins.sorted {
                    $0.num ?? 0 > $1.num ?? 0
                }
            }
        
        return Observable
            .combineLatest(
                Observable.just(championKey),
                Observable.just(championName),
                skins) { key, name, skins in
                    skins.map { skin -> ChampionSkinInfo in
                        if skin.name == "default" {
                            return ChampionSkinInfo(championIdentity : key, skinName : name, skinIdentity : skin.num ?? 0)
                        }else {
                            return ChampionSkinInfo(championIdentity : key, skinName : skin.name, skinIdentity : skin.num ?? 0)
                        }
                    }
                }
    }
    
    func getTags() -> Observable<[String]>{
        let tags = self.championDetailResult
            .map { api -> [String] in
                guard let api = api else {
                    return []
                }
                var tags = api.data.champion.tags
                tags.insert(api.data.champion.title ?? "", at: 0)
                return tags
            }
        
        return tags
    }
    
    
    func getSkills(champion : Champion) -> Observable<[ChampionListApi.Champion.Skill]> {
        return champion
            .map { result -> [ChampionListApi.Champion.Skill] in
                var spells = result.spells
                spells.insert(result.passive, at: 0)
                return spells
            }
    }
    
    func getSkills() -> Observable<[ChampionListApi.Champion.Skill]> {
        return championInfo
            .map { result -> [ChampionListApi.Champion.Skill] in
                var spells = result.spells
                spells.insert(result.passive, at: 0)
                return spells
            }
    }
    
    func getLore() -> Observable<String> {
        return self.championDetailResult
            .map { api -> String in
                guard let api = api else {
                    return ""
                }
                return api.data.champion.lore ?? ""
            }
    }
    
    func getPlayerLank(champion : Observable<Champion>) -> Observable<[ChampionGoodAtPlayerApi.Player]> {
        let playerLankResult = champion
            .flatMapLatest { [weak self] champion in
                self?.apiService.championGoodAtPlayerRank(championKey: champion.key) ?? .just(.failure(.networkError))
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
    
    func getPlayerLank(championKey : Observable<String>) -> Observable<[ChampionGoodAtPlayerApi.Player]> {
        let playerLankResult = championKey
            .flatMapLatest { [weak self] championKey in
                self?.apiService.championGoodAtPlayerRank(championKey: championKey) ?? .just(.failure(.networkError))
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
            .flatMapLatest { [weak self] champion in
                self?.apiService.championComment(championKey: champion.key) ?? .just(.failure(.networkError))
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
    
    func getComment(championKey : Observable<String> ) -> Observable<[ChampionCommentApi.Comment]> {
        let championCommentResult = championKey
            .flatMapLatest { [weak self] championKey in
                self?.apiService.championComment(championKey: championKey) ?? .just(.failure(.networkError))
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
            .flatMapLatest { [weak self] champion in
                self?.apiService.championCommentCount(championKey: champion.key) ?? .just(.failure(.networkError))
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
    
    func getCommentCount(championKey : Observable<String>) -> Observable<Int> {
        let championCommentCountResult = championKey
            .flatMapLatest { [weak self] championKey in
                self?.apiService.championCommentCount(championKey: championKey) ?? .just(.failure(.networkError))
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


