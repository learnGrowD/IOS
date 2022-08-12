//
//  DetailRepository.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/09.
//

import Foundation
import RxSwift
import RxCocoa


typealias ChampionUserComment = (comment : [ChampionCommentApi.Comment], commentCount : Int)
typealias ChampionSkinInfo = (championIdentity : String, skinIdentity : [Int])
enum ChampionDetailPageSectionType {
    case skins(_ headerTitle : String, _ data : ChampionSkinInfo)
    case tags(_ headerTitle : String, _ data : [String])
    case skills(_ headerTitle : String, _ data : [ChampionListApi.Champion.Skill])
    case lore(_ headerTitle : String, _ data : String)
    case playerLank(_ headerTitle : String, _ data : [ChampionGoodAtPlayerApi.Player])
    case championComment(_ headerTitle : String, _ data : ChampionUserComment)
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
    
    
    func championDetailData(champion : Observable<Champion>) -> BehaviorSubject<UiState<[ChampionDetailPageSectionType]>> {
        let championDetailResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championDetail(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()

        let playerLankResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championGoodAtPlayerRank(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()
        let championCommentResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championComment(champion: abc.key) ?? .just(.failure(.networkError))
            }
            .share()
        let championCountResult = champion
            .flatMapLatest { [weak self] abc in
                self?.apiService.championCommentCount(champion: abc.key).asObservable() ?? .just(.failure(.networkError))
            }
            .share()
            
        let skins = championDetailResult
            .map { result -> ChampionSkinInfo in
                guard case .success(let api) = result else {
                    return ("", [])
                }
                let skinIdentitys = api.data.champion.skins
                    .map {
                        $0.num ?? 0
                    }

                return (api.data.champion.id ?? "", skinIdentitys)
            }


        let tags = championDetailResult
            .map { result -> [String] in
                guard case .success(let api) = result else {
                    return []
                }
                let tags = api.data.champion.tags
                return tags
            }

        let skills = champion
            .map { result -> [ChampionListApi.Champion.Skill] in
                var spells = result.spells
                spells.append(result.passive)
                return spells
            }


        let lore = championDetailResult
            .map { result -> String in
                guard case .success(let api) = result else {
                    return ""
                }
                return api.data.champion.lore ?? ""
            }
            


        let playerRank = playerLankResult
            .map { result -> [ChampionGoodAtPlayerApi.Player] in
                guard case .success(let api) = result else {
                    return []
                }
                return api.data
            }


        let comment = championCommentResult
            .map { result -> [ChampionCommentApi.Comment] in
                guard case .success(let api) = result else {
                    return []
                }
                return api.data
            }

        let commentCount = championCountResult
            .map { result -> Int in
                guard case .success(let api) = result else {
                    return -1
                }
                return api.data.count ?? -1
            }
        
        let combineValue = Observable
            .combineLatest(
                skins,
                tags,
                skills,
                lore,
                playerRank,
                comment,
                commentCount) { a, b, c, d, e, f, g -> [ChampionDetailPageSectionType] in
                    let detailPageData : [ChampionDetailPageSectionType] = [
                        .skins("스킨", a),
                        .tags("태그", b),
                        .skills("스킬", c),
                        .lore("스토리", d),
                        .playerLank("순위", e),
                        .championComment("댓글", (comment : f, commentCount : g))
                    ]
                    return detailPageData
            }
        let subject = BehaviorSubject<UiState<[ChampionDetailPageSectionType]>>(value: .loading)
        combineValue
            .subscribe(onNext : {
                subject.onNext(.success($0))
            })
            .disposed(by: disposeBag)
        return subject
        
    }
}


