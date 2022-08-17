//
//  RecommendViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/17.
//

import Foundation
import RxCocoa
import RxSwift



struct RecommendViewModel {
    let disposeBag = DisposeBag()
    let championRecommendList : Driver<[ChampionRecommend]>
    
    init(_ mainRepository : MainRepository = MainRepository.instance) {
        
        championRecommendList = mainRepository.getHomeRecommendChampionList()
            .asDriver(onErrorDriveWith: .empty())
    }
}
