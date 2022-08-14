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
    let skinIdentity : Int
}


typealias ChampionUserComment = (comment : [ChampionCommentApi.Comment], commentCount : Int)
enum ChampionDetailPageDataModel {
    case skins(title : String, _ data : [ChampionSkinInfo])
    case tags(title : String, _ data : [String])
    case skills(title : String, _ data : [ChampionListApi.Champion.Skill])
    case lore(title : String, _ data : String)
    case playerLank(title : String, _ data : [ChampionGoodAtPlayerApi.Player])
    case championComment(title : String, _ data : (commentCount : Int, comment : [ChampionCommentApi.Comment]))
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
        
        let skinNums = championDetailResult
            .map { result -> [Int] in
                guard case .success(let api) = result else {
                    return []
                }
                let skinIdentitys = api.data.champion.skins
                    .map {
                        $0.num ?? 0
                    }
                return skinIdentitys
            }
        
        return Observable
            .combineLatest(
                skinNums,
                champion) { a, b -> [ChampionSkinInfo] in
                    let skin = a.map {
                        ChampionSkinInfo(championIdentity : b.key ?? "", skinIdentity : $0)
                    }
                    return skin
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
                spells.append(result.passive)
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
                return api.data
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
    
    
    
    
//
//    func championDetailData(champion : Observable<Champion>) -> BehaviorSubject<UiState<[ChampionDetailPageSectionType]>> {
//        let championDetailResult = champion
//            .flatMapLatest { [weak self] abc in
//                self?.apiService.championDetail(champion: abc.key) ?? .just(.failure(.networkError))
//            }
//            .share()
//
//        let playerLankResult = champion
//            .flatMapLatest { [weak self] abc in
//                self?.apiService.championGoodAtPlayerRank(champion: abc.key) ?? .just(.failure(.networkError))
//            }
//            .share()
//        let championCommentResult = champion
//            .flatMapLatest { [weak self] abc in
//                self?.apiService.championComment(champion: abc.key) ?? .just(.failure(.networkError))
//            }
//            .share()
//        let championCountResult = champion
//            .flatMapLatest { [weak self] abc in
//                self?.apiService.championCommentCount(champion: abc.key).asObservable() ?? .just(.failure(.networkError))
//            }
//            .share()
//
//
//
//
//        let comment = championCommentResult
//            .map { result -> [ChampionCommentApi.Comment] in
//                guard case .success(let api) = result else {
//                    return []
//                }
//                return api.data
//            }
//
//        let commentCount = championCountResult
//            .map { result -> Int in
//                guard case .success(let api) = result else {
//                    return -1
//                }
//                return api.data.count ?? -1
//            }
//
//        let combineValue = Observable
//            .combineLatest(
//                skins,
//                tags,
//                skills,
//                lore,
//                playerRank,
//                comment,
//                commentCount) { a, b, c, d, e, f, g -> [ChampionDetailPageSectionType] in
//                    let detailPageData : [ChampionDetailPageSectionType] = [
//                        .skins("스킨", a),
//                        .tags("태그", b),
//                        .skills("스킬", c),
//                        .lore("스토리", d),
//                        .playerLank("순위", e),
//                        .championComment("댓글", (comment : f, commentCount : g))
//                    ]
//                    return detailPageData
//            }
//        let subject = BehaviorSubject<UiState<[ChampionDetailPageSectionType]>>(value: .loading)
//        combineValue
//            .subscribe(onNext : {
//                subject.onNext(.success($0))
//            })
//            .disposed(by: disposeBag)
//        return subject
//
//    }
}


