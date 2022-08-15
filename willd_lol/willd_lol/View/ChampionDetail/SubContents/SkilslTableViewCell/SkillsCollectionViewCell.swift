//
//  SkillsCell.swift
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
import Kingfisher



class SkillsCollectionViewCell : UICollectionViewCell {
    let disposeBag = DisposeBag()
    let skillKey = UILabel().then {
        $0.textColor = .willdWhite
        $0.sizeToFit()
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    let skillImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let skillNameLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12)
    }
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
     
    func bind(index : IndexPath, _ viewModel : SkillsViewModel) {
        let row = Observable.just(index.row)
        let skill = row
            .flatMapLatest { row in
                viewModel.skills
                    .map { skill in
                        skill[row]
                    }
            }
        
        skill
            .bind(onNext : { [weak self] in
                self?.skillKey.text = $0.key ?? "P"
                self?.skillImageView.kf.setImage(with: ImageUrlConverter.convertImgUrl($0.imageUrl))
                self?.skillNameLabel.text = $0.name
                
            })
            .disposed(by: disposeBag)
            
        

             
     }
     
     private func attribute() {
         
     }
     
     private func layout() {
         [
            skillImageView,
            skillKey,
            skillNameLabel
         ].forEach {
             contentView.addSubview($0)
         }
         skillKey.snp.makeConstraints {
             $0.top.leading.equalTo(skillImageView)
         }
         
         skillImageView.snp.makeConstraints {
             $0.width.height.equalTo(80)
             $0.leading.top.trailing.equalToSuperview()
         }
         
         
         skillNameLabel.snp.makeConstraints {
             $0.top.equalTo(skillImageView.snp.bottom).offset(8)
             $0.trailing.leading.equalToSuperview()
         }
         
         
     }
}
