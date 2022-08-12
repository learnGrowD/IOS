//
//  ChampionListViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/10.
//

import UIKit
import RxCocoa
import RxSwift


//RxSwift
//Observable
//Subject : PublishSubject, BehaviorSubject, RelaySubject
//Traits : Single, Maybe, Completed

//RxCocoa
//Binder
//Subject : PublishRelay, BehaviorRelay
//Traits : Drivaer, Signal


//bind는 UI Thread에서 실행하는것을 보장
//Error event 방출은 하지만! 로그로만 출력...

struct ChampionListViewModel {
    
    let shouldPresedentChampionList : Driver<[Champion]>
    
    init(_ repository : MainRepository = MainRepository.instance) {
        let championListPageData = repository.championListPageData()
            .map { uiState -> [Champion] in
                guard case .success(let value) = uiState else {
                    return []
                }
                return value
            }
        self.shouldPresedentChampionList = championListPageData
            .asDriver(onErrorJustReturn: [])
    }
    
}



