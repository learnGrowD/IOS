//
//  CommentCell.swift
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



class CommentCollectionViewCell : UICollectionViewCell {
    let disposeBag = DisposeBag()
    let nameLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
        
    let contentLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    let voteLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.font = .systemFont(ofSize: 18, weight: .bold)

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
     
    func bind(index : IndexPath,_ viewModel : CommentViewModel) {
        
        let row = Observable.just(index.row)
        let comment = row
            .flatMapLatest { row in
                viewModel.comment
                    .map {
                        $0.comment[row]
                    }
            }
        comment
            .bind(onNext : { [weak self] in
                guard let self = self else { return }
                self.nameLabel.text = $0.user.username
                self.contentLabel.text = $0.content
                self.voteLabel.text = String(describing: $0.vote ?? 0)
            })
            .disposed(by: disposeBag)
         
     }
     
     private func attribute() {
         
     }
     
     private func layout() {
         [
            nameLabel,
            contentLabel,
            voteLabel
         ].forEach {
             contentView.addSubview($0)
         }
         
         nameLabel.snp.makeConstraints {
             $0.top.equalToSuperview().inset(18)
             $0.leading.equalToSuperview()
         }
         
         contentLabel.snp.makeConstraints {
             $0.top.equalTo(nameLabel.snp.bottom).offset(12)
             $0.leading.equalTo(nameLabel.snp.leading)
             $0.trailing.equalTo(voteLabel.snp.leading).offset(-24)
         }
         
         voteLabel.snp.makeConstraints {
             $0.trailing.equalToSuperview()
             $0.centerY.equalToSuperview()
         }
    
     }
}
