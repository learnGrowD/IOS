//
//  ContentCollectionViewCell.swift
//  Ex01Snapkit
//
//  Created by 도학태 on 2022/07/22.
//

import UIKit
import SnapKit
import Then

class ContentCollectionViewCell : UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
