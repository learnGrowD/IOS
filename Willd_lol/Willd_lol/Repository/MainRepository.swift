
import Foundation
import RxSwift

typealias Champion = ChampionListApi.Champion
protocol MainRepositoryProtocal {
    func getChampionListPageData() -> BehaviorSubject<UiState<[Champion]>>
}

class MainRepository {
    static let instance = MainRepository()
    private let apiService : ApiService
    private let disposeBag = DisposeBag()
    private init() {
        apiService = ApiService.instance
    }
    func getHomeRecommendChampionList(page : Observable<Int>) -> Observable<[ChampionRecommendApi.Result]> {
        let recommendResult = page
            .flatMapLatest { [weak self] page in
                return self?.apiService.championRecommend(page: page) ?? .just(.failure(.networkError))
            }
            .share()
        
        return recommendResult
            .map { result -> [ChampionRecommendApi.Result] in
                guard case .success(let api) = result else {
                    return []
                }
                return api.results
            }
    }
    
    func getHomeChampionTierList(info : Observable<(tier : RankTier, lane : PlayerLane)>) -> Observable<[ChampionTierListApi.Champion]> {
        let tierListResult = info
            .flatMapLatest { [weak self] info in
                self?.apiService.championTierList(
                    tier: info.tier,
                    lane: info.lane,
                    orderby: .topScore,
                    listCount: 5
                )
                ?? .just(.failure(.networkError))
            }
            .share()
        
            
        return tierListResult
            .map { result -> [ChampionTierListApi.Champion] in
                guard case .success(let api) = result else {
                    return []
                }
                return api.results
            }
    }
    
    func getPlayerLankList(info : Observable<(category : PlayerCategory, listCount : Int)>) -> Observable<[PlayerMmrRankApi.PlayerInfo]> {
        let playerLankResult =
            self.apiService.selectedPlayerMmrRank()
            .asObservable()
        
        return Observable
            .combineLatest(
                info,
                playerLankResult) { info, result -> [PlayerMmrRankApi.PlayerInfo] in
                    guard case .success(let api) = result else {
                        return [] //failur....
                    }
                    switch info.category {
                    case .pro:
                        var newValues : [PlayerMmrRankApi.PlayerInfo] = []
                        api.pro
                            .enumerated()
                            .forEach { index, value in
                                if index <= info.listCount {
                                    newValues.append(value)
                                }
                            }
                        return newValues
                    case .popular:
                        var newValues : [PlayerMmrRankApi.PlayerInfo] = []
                        api.named
                            .enumerated()
                            .forEach { index, value in
                                if index <= info.listCount {
                                    newValues.append(value)
                                }
                            }
                        return newValues
                    case .recommend:
                        var newValues : [PlayerMmrRankApi.PlayerInfo] = []
                        api.all
                            .enumerated()
                            .forEach { index, value in
                                if index <= info.listCount {
                                    newValues.append(value)
                                }
                            }
                        return newValues
                    }
                }
    }
    
    
    
    
    
    func getChampionListPageData() -> BehaviorSubject<UiState<[Champion]>> {
        let subject = BehaviorSubject<UiState<[Champion]>>(value: UiState.loading)
        apiService.championList()
            .subscribe(onSuccess : { result in
                switch result {
                case .success(let api):
                    if api.data.isEmpty {
                        subject.onNext(.empty)
                    } else {
                        let sorListtData = api.data.sorted(by: {$0.id! > $1.id!})
                        subject.onNext(.success(sorListtData))
                    }
                case .failure(let error):
                    subject.onNext(.invalid(error.localizedDescription))
                }
            })
            .disposed(by: disposeBag)
        return subject
    }
    
}


enum PlayerCategory : Int {
    case pro = 0
    case popular = 1
    case recommend = 2
}
