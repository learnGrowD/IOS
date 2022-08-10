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
    
    let shouldPresedentChampionPageData : Driver<[Champion]>
    
    init(_ repository : MainRepository = MainRepository.instance) {
        let championListPageData = repository.championListPageData()
            .map { uiState -> [Champion] in
                guard case .success(let value) = uiState else {
                    return []
                }
                return value.listData
            }
        
        self.shouldPresedentChampionPageData = championListPageData
            .asDriver(onErrorJustReturn: [])
    }
    
}



