//
//  LoreViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import RxCocoa
import RxSwift


struct LoreViewModel {
    let lore : Driver<String>
    
    init(champion : Observable<Champion>,
         _ detailRepository : DetailRepository = DetailRepository.instance) {
        
        lore = detailRepository.getLore(champion: champion)
            .asDriver(onErrorDriveWith: .empty())
    }
}
