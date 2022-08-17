//
//  TierViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/17.
//

import Foundation
import RxCocoa
import RxSwift



struct TierListViewModel {
    let disposeBag = DisposeBag()
    let info = BehaviorRelay<(tier : RankTier, lane : PlayerLane)>(value: (.etc, .mid))
    let tierList : Driver<[ChampionTier]>
    
    init(_ mainRepository : MainRepository = MainRepository.instance) {
//        let tier = Observable<[RankTier]>.just(
//            [
//                .etc,
//                .platinum,
//                .diamond,
//                .master
//            ]
//        )
//            .map {
//                $0.randomElement() ?? .etc
//            }
//
//        let playerLane = Observable<[PlayerLane]>.just(
//            [
//                .top,
//                .jungle,
//                .mid,
//                .bottom,
//                .supporter
//            ]
//        )
//            .map {
//                $0.randomElement() ?? .mid
//            }
        
        self.tierList = info
            .flatMapLatest {
                mainRepository.getHomeChampionTierList(info: Observable.just($0))
            }
            .asDriver(onErrorDriveWith: .empty())
        
//        tierList
//            .drive(onNext : {
//                print($0)
//            })
//            .disposed(by: disposeBag)
        
//        let info = Observable
//            .combineLatest(
//                tier,
//                playerLane) {
//                    (tier : $0, lane : $1)
//                }
//        tierList = mainRepository.getHomeChampionTierList(info: info)
//            .asDriver(onErrorDriveWith: .empty())
        
    }
}
