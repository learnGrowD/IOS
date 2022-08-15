//
//  ContentCollectionViewHeader.swift
//  Ex03UICollectionView
//
//  Created by 도학태 on 2022/07/25.
//

import UIKit

class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight : .bold)
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(sectionNameLabel)
        constraintView()
        
        
    }
    
    func constraintView() {
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(10)
        }
    }
}
