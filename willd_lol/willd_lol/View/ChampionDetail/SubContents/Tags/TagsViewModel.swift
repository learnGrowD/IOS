//
//  TagsViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import RxCocoa
import RxSwift



struct TagsViewModel {
    
    let tags : Driver<[String]>
    
    init(champion : Observable<Champion>,
         _ detailRepository : ChampionDetailRepository = ChampionDetailRepository.instance) {
        tags = detailRepository.getTags(champion: champion)
            .asDriver(onErrorDriveWith: .empty())
    }
    
}
