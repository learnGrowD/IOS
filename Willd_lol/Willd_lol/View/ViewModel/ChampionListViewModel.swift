//
//  ChampionListViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/10.
//

import UIKit
import RxCocoa
import RxSwift

struct ChampionListViewModel {
    
    let shouldPresedentChampionList : Driver<[Champion]>
    
    init(_ repository : MainRepository = MainRepository.instance) {
        let championListPageData = repository.championListPageData()
            .map { uiState -> [Champion] in
                guard case .success(let value) = uiState else {
                    return []
                }
                print("아니얌")
                return value.listData
            }
        self.shouldPresedentChampionList = championListPageData
            .asDriver(onErrorJustReturn: [])
    }
    
}



