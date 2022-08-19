//
//  SkinViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import RxSwift
import RxCocoa


struct SkinsViewModel {
    let disPoseBag = DisposeBag()
    let skins = BehaviorRelay<[ChampionSkinInfo]>(value: [])
    init(champion : Champion) {
        let detailRepository = DetailRepository(champion: champion)
        
        detailRepository.getSkins(champion: champion)
            .bind(to: skins)
            .disposed(by: disPoseBag)
    }
    init(championKey : String, championName : String) {
        let detailRepository = DetailRepository(championKey: championKey)
        
        detailRepository.getSkins(championKey: championKey, championName: championName)
            .bind(to: skins)
            .disposed(by: disPoseBag)
    }
}

