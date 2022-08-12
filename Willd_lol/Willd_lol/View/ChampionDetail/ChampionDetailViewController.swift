//
//  ChampionDetailViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/11.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ChampionDetailViewController : UIViewController {
    let disposeBag = DisposeBag()
    
    
    let progressBar = UIActivityIndicatorView(style: .medium).then {
        $0.hidesWhenStopped = true
        $0.startAnimating()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel : ChampionDetailViewModel) {
        viewModel.shouldPresentProgress
            .drive(progressBar.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        
        
    }
    
    func layout() {
        [progressBar].forEach {
            view.addSubview($0)
        }
        progressBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
