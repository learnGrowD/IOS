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
    
    let playerDetailData : Driver<[PlayerDetailData]>
    
    let summonerViewModel = SummonerViewModel()
    let mostChampionGuideViewModel = MostChampionGuideViewModel()
    let mostChampionViewModel = MostChampionViewModel()
    let matchViewModel = MatchViewModel()

    init(playerName : String) {
        repository = PlayerDetailRepository(playerName: playerName)
        
        repository.getSummoner()
            .bind(to: summonerViewModel.summonerData)
            .disposed(by: disposeBag)
        
        repository.getMostChampion()
            .bind(to: mostChampionGuideViewModel.mostChampionGuideData)
            .disposed(by: disposeBag)
        
        
        repository.getMostChampionItems()
            .bind(to: mostChampionViewModel.mostChampionData)
            .disposed(by: disposeBag)
        
        repository.getMatches()
            .bind(to: matchViewModel.matchData)
            .disposed(by: disposeBag)
        
        
        playerDetailData = Observable
            .combineLatest(
                summonerViewModel.summonerData.asObservable(),
                mostChampionGuideViewModel.mostChampionGuideData.asObservable(),
                mostChampionViewModel.mostChampionData.asObservable(),
                matchViewModel.matchData.asObservable()) { summoner, mostChampionGuide, mostChampion, match -> [PlayerDetailData] in
                    let result : [PlayerDetailData] = [
                        .summoner("A", summoner),
                        .mostChampionGuide("B", mostChampionGuide),
                        .mostChampion("C", mostChampion),
                        .match("D", match)
                    ]
                    return result
                }
                .asDriver(onErrorDriveWith: .empty())
    }
    
}
