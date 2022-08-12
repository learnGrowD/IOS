
import Foundation
import RxSwift


typealias Champion = ChampionListApi.Champion
protocol MainRepositoryProtocal {
    
//    func homePageData() -> PublishSubject<UiState<HomePageData>>
    func championListPageData() -> BehaviorSubject<UiState<[Champion]>>
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
    
    func championListPageData() -> BehaviorSubject<UiState<[Champion]>> {
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
