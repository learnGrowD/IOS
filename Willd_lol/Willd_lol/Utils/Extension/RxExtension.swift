//
//  RxExtension.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/11.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Then

extension Reactive where Base : UIViewController {
    var translateChampionDetailScreen : Binder<Champion> {
        return Binder(base) { base, data in
            let detailVc = ChampionDetailViewController().then { cotroller in
                cotroller.hidesBottomBarWhenPushed = true
                cotroller.champion = data
                cotroller.title = data.name
            }
            base.show(detailVc, sender: nil)
        }
    }
}
