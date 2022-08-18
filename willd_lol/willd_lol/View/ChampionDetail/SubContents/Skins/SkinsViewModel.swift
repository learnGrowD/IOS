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
    init(champion : Observable<Champion>,
         _ detailRepository : ChampionDetailRepository = ChampionDetailRepository.instance) {
        
        detailRepository.getSkins(champion: champion)
            .bind(to: skins)
            .disposed(by: disPoseBag)
    }
}

