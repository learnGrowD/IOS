//
//  PlayerDetailViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/20.
//

import Foundation
import RxCocoa
import RxSwift


struct PlayerDetailViewModel {
    let disposeBag = DisposeBag()
    let repository : PlayerDetailRepository
    
    let summonerViewModel = SummonerViewModel()
    let mostChampionViewModel = MostChampionViewModel()
    let matchViewModel = MatchViewModel()

    init(playerName : String) {
        repository = PlayerDetailRepository(playerName: playerName)
        
        repository.getSummoner()
            .bind(to: summonerViewModel.summonerData)
            .disposed(by: disposeBag)
        
        
    }
    
}
