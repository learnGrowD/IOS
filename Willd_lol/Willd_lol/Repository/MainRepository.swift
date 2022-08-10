
import Foundation
import RxSwift


protocol MainRepositoryProtocal {
    
//    func homePageData() -> PublishSubject<UiState<HomePageData>>
    func championListPageData() -> BehaviorSubject<UiState<ChampionListPageData>>
}

class MainRepository : MainRepositoryProtocal {
    static let instance = MainRepository()
    private let apiService : ApiService
    private let disposeBag = DisposeBag()
    private init() {
        apiService = ApiService.instance
    }
    
    
//    func homePageData() -> PublishSubject<UiState<HomePageData>> {
//        <#code#>
//    }
    
    func championListPageData() -> BehaviorSubject<UiState<ChampionListPageData>> {
        let subject = BehaviorSubject<UiState<ChampionListPageData>>(value: UiState.loading)
        apiService.championList()
            .subscribe(onSuccess : { result in
                switch result {
                case .success(let api):
                    if api.data.isEmpty {
                        subject.onNext(.empty)
                    } else {
                        let sorListtData = api.data.sorted(by: {$0.id! > $1.id!})
                        let substantialData = ChampionListPageData(listData: sorListtData)
                        subject.onNext(.success(substantialData))
                    }
                case .failure(let error):
                    subject.onNext(.invalid(error.localizedDescription))
                }
            })
            .disposed(by: disposeBag)
        return subject
    }
    
}
