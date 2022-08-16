//
//  ContentCollectionViewCell.swift
//  Ex03UICollectionView
//
//  Created by 도학태 on 2022/07/25.
//

import UIKit
import SnapKit
import Then

class ContentCollectionViewCell: UICollectionViewCell {
    let img = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        petchContentView()
        constraintView()
    }
    
    func petchContentView() {
        let _ = contentView.then {
            [img].forEach { [weak contentView] mView in
                contentView?.addSubview(mView)
            }
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
        }
    }
    
    func constraintView() {
        img.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
