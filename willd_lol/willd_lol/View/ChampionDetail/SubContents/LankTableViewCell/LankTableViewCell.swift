//
//  LankCell.swift
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



class LankTableViewCell : UITableViewCell {
    let disposeBag = DisposeBag()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
     
     func bind(_ viewModel : LankViewModel) {
         
     }
     
     private func attribute() {
         
     }
     
     private func layout() {
         
     }
}
