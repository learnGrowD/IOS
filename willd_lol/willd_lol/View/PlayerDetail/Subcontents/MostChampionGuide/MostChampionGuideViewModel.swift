//
//  MostChampionViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/20.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit


struct MostChampionGuideViewModel {
    let disposeBag = DisposeBag()
    
    let mostChampionGuideData = BehaviorRelay<PlayerDetailApi.MostChampion?>(value: nil)
    
    let laneImageUrl : Driver<UIImage?>
    let lane : Driver<String>
    let matchInfo : Driver<String>
    
    init() {
        laneImageUrl = mostChampionGuideData
            .filter { $0 != nil }
            .map {
                switch $0?.lane {
                case "탑":
                    return UIImage(named: "Position_Diamond-Top")
                case "정글":
                    return UIImage(named: "Position_Diamond-Jungle")
                case "미드":
                    return UIImage(named: "Position_Diamond-Mid")
                case "원딜":
                    return UIImage(named: "Position_Diamond-Bot")
                case "서폿":
                    return UIImage(named: "Position_Diamond-Support")
                default:
                    return UIImage(named: "")
                }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        lane = mostChampionGuideData
            .filter { $0 != nil }
            .map {
                $0?.lane ?? ""
            }
            .asDriver(onErrorDriveWith: .empty())
        
        matchInfo = mostChampionGuideData
            .filter { $0 != nil }
            .map {
                "\($0?.matchCount ?? 0) 경기 / 승률 \($0?.winRate ?? 0.0)%"
            }
            .asDriver(onErrorDriveWith: .empty())
        
    }
    
    
    

    
}
