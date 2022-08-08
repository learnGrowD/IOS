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
import Kingfisher
import SnapKit


class MainViewController : UIViewController {
    let a = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        a.kf.setImage(with: Converter.convertChampionFullImgPath(type: .full, championKey: "Talon", skinIdentity: 20))
        
        
        view.addSubview(a)
        
        a.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    
    
}

