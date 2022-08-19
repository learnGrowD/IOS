//
//  MatchCollectionViewCell.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Then



class MatchCollectionViewCell : UICollectionViewCell {
    let disposeBag = DisposeBag()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        attribute()
        layout()
    }
    
    
    func bind(_ viewModel : MatchViewModel) {
        
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        
    }
    
    
}
