//
//  TagCell.swift
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


class TagsTableViewCell : UITableViewCell {
    let disposeBag = DisposeBag()
    let stackView = UIStackView().then {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 12
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
     
     func bind(_ viewModel : TagsViewModel) {
         viewModel.tags
             .drive(onNext : { [weak self] in
                 let label = $0.map { tag in
                     UILabel().then { label in
                         label.text = tag
                         label.textColor = .willdWhite
                         label.font = .systemFont(ofSize: 12)
                     }
                 }

                 label.forEach {
                     self?.stackView.addArrangedSubview($0)
                 }
             })
             .disposed(by: disposeBag)
     }
     
     private func attribute() {
         contentView.backgroundColor = .willdBlack
     }
     
     private func layout() {
         [stackView].forEach {
             contentView.addSubview($0)
         }
         stackView.snp.makeConstraints {
             $0.leading.equalToSuperview().inset(18)
             $0.top.bottom.equalToSuperview()
            
         }
     }
}
