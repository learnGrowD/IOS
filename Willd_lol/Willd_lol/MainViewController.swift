//
//  MainViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/06.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Then


class MainViewController : UIViewController {
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        Network().abc(champion: "Darius")
            .subscribe(onSuccess : {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
}

