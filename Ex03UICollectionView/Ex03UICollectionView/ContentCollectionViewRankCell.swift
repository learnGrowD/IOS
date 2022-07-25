//
//  ContentCollectionViewRankCell.swift
//  Ex03UICollectionView
//
//  Created by 도학태 on 2022/07/25.
//

import UIKit
import SnapKit
import Then

class ContentCollectionViewRankCell: UICollectionViewCell {
    let img = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let rankLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 100, weight : .bold)
        $0.textColor = .white
        $0.backgroundColor = .systemPink
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        registContentView()
        constraintView()
    }
    
    func registContentView() {
        [img, rankLabel].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    func constraintView() {
        img.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
//            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(24)
        }
    }

    
    
    
}
