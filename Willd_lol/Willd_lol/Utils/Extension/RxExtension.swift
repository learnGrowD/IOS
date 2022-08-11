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

extension Reactive where Base : UIViewController {
    var translateChampionDetailScreen : Binder<Champion> {
        return Binder(base) { base, data in
            let rootViewController = ChampionDetailViewController()
            rootViewController.champion = data
            let navicationController = UINavigationController(rootViewController: rootViewController)
            base.show(navicationController, sender: nil)
        }
    }
}
