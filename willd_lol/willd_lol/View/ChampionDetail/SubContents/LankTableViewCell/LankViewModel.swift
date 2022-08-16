//
//  LankViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import RxCocoa
import RxSwift


struct LankViewModel {
    let lank : Driver<[ChampionGoodAtPlayerApi.Player]>
    
    init(champion : Observable<Champion>,
         _ detailRepository : ChampionDetailRepository = ChampionDetailRepository.instance) {
        lank = detailRepository.getPlayerLank(champion: champion)
            .asDriver(onErrorDriveWith: .empty())
        
    }
}

