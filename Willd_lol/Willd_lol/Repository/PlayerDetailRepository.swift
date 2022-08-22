//
//  PlayerDetailRepository.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/22.
//

import Foundation
import RxCocoa
import RxSwift
import Then


enum PlayerDetailData {
    case summoner(_ title : String, _ data : (summoner : PlayerDetailApi.Summoner, stats : PlayerDetailApi.Summary)?)
    case mostChampionGuide(_ title : String, _ data : PlayerDetailApi.MostChampion?)
    case mostChampion(_ title : String, _ data : [PlayerDetailApi.MostChampion.Item])
    case match(_ title : String, _ data : [PlayerDetailApi.Match])
}



struct PlayerDetailRepository {
    let disposeBag = DisposeBag()
    let apiService = ApiService.instance
    let playerDetailApi = BehaviorSubject<PlayerDetailApi?>(value: nil)
    
    init(playerName : String) {
       apiService.playerDetail(playerName: playerName)
            .map { result -> PlayerDetailApi? in
                guard case .success(let api) = result else {
                    return nil
                }
                return api
            }
            .asObservable()
            .bind(to: self.playerDetailApi)
            .disposed(by: disposeBag)
    }
    
    
    func getSummoner() -> Observable<(summoner : PlayerDetailApi.Summoner, stats : PlayerDetailApi.Summary)> {
        playerDetailApi
            .filter { $0 != nil }
            .map {
                ($0!.summoner, $0!.summary)
            }
            .asObservable()
    }
    
    func getMostChampion() -> Observable<PlayerDetailApi.MostChampion> {
        playerDetailApi
            .filter { $0 != nil }
            .map {
                $0!.mostChampions[0]
            }
            .asObservable()
    }
    
    func getMostChampionItems() -> Observable<[PlayerDetailApi.MostChampion.Item]> {
        playerDetailApi
            .filter { $0 != nil }
            .map {
                var result : [PlayerDetailApi.MostChampion.Item] = []
                $0!.mostChampions[0].items
                    .enumerated()
                    .forEach { index, item in
                        if index != 0 {
                            result.append(item)
                        }
                    }
                return result
            }
            .asObservable()
    }
    
    func getMatches() -> Observable<[PlayerDetailApi.Match]> {
        playerDetailApi
            .filter { $0 != nil }
            .map {
                $0!.matches
            }
            .asObservable()
    }
    
}
