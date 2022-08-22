//
//  MatchViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/20.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit


class MatchViewModel {
    let disposeBag = DisposeBag()
    
    let matchData = BehaviorRelay<[PlayerDetailApi.Match]>(value: [])
    
    var result : Driver<String>?
    var resultColor : Driver<UIColor?>?
    
    var laneImage : Driver<UIImage?>?
    
    var gameTime : Driver<String>?
    var championImageUrl : Driver<URL?>?

    var kdaInfo : Driver<String>?
    var csInfo : Driver<String>?
    var killPoint : Driver<String>?
    
    func bind(index : IndexPath) {
        let match = matchData
            .filter { !$0.isEmpty }
            .map {
                $0[index.row]
            }
        
        result = match
            .map {
                $0.result ?? ""
            }
            .asDriver(onErrorDriveWith: .empty())
        
        resultColor = match
            .map {
                if $0.result == "WIN" {
                    return UIColor.systemBlue
                } else {
                    return UIColor.systemRed
                }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        
        laneImage = match
            .map {
                switch $0.me.lane {
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
        
        let dateTiem = match
            .map { match -> String in
                let currentMStime = Double(match.matchDate ?? 0 / 1000)
                let date = Date(timeIntervalSince1970: currentMStime)
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "ko_kr")
                formatter.dateFormat = "yyyy.MM.dd"
                let currentDateStr = formatter.string(from: date)
                return currentDateStr
            }
        
         let playTime = match
            .map {
                "\($0.gameTime ?? 0 / 60)분"
            }
        
        gameTime = Observable
            .combineLatest(
                dateTiem,
                playTime) {
                    "\($0) / \($1)"
                }
                .asDriver(onErrorDriveWith: .empty())

        
        championImageUrl = match
            .map {
                UrlConverter.convertChampionImgUrl(type: .small, championKey: $0.me.championKey)
            }
            .asDriver(onErrorDriveWith: .empty())
        
        kdaInfo = match
            .map {
                "\($0.me.kills!) / \($0.me.deaths!) / \($0.me.assists!) (\($0.me.kda!)"
            }
            .asDriver(onErrorDriveWith: .empty())
        
        csInfo = match
            .map {
                "CS : \($0.me.cs!) / MCS : \($0.me.csPerMinute!)"
            }
            .asDriver(onErrorDriveWith: .empty())
        
        killPoint = match
            .map {
                "\($0.me.killParticipation!)% KP"
            }
            .asDriver(onErrorDriveWith: .empty())
    }
    
    

    
}
