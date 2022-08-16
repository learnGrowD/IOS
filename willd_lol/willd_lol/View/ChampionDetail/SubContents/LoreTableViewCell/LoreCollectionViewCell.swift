//
//  LoreCell.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit



class LoreCollectionViewCell : UICollectionViewCell {
    let disposeBag = DisposeBag()
    let loreLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 16)
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        attribute()
//        layout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        attribute()
        layout()
    }
     
     
     func bind(_ viewModel : LoreViewModel) {
         viewModel.lore
             .drive(loreLabel.rx.text)
             .disposed(by: disposeBag)

     }
    
    
     private func attribute() {
         
     }
     
     private func layout() {
         [loreLabel].forEach {
             contentView.addSubview($0)
         }
         loreLabel.snp.makeConstraints {
             $0.edges.equalToSuperview()
         }
     }
    
    

}
