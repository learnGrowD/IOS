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
    let sholdPresentSkins : Driver<[ChampionSkinInfo]>
    let skinValue = PublishRelay<[ChampionSkinInfo]>()
    init() {
        self.sholdPresentSkins = skinValue
            .asDriver(onErrorDriveWith: .empty())
        
        sholdPresentSkins
            .drive(onNext : {
                print($0.count)
            })
        
        
    }
    
}

