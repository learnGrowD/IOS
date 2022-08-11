//
//  ChampionListViewCell.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/10.
//

import Foundation
import UIKit
import Then
import SnapKit
import Kingfisher


class ChampionListViewCell : UICollectionViewCell {
    
    let imagView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        contentView.backgroundColor = .willdBlack
        contentView.addSubview(imagView)
        imagView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(data : ChampionListApi.Champion) {
        imagView.kf.setImage(with: ImageUrlConverter.convertChampionImgUrl(type: .middle, championKey: data.key))
    }
    
    
}
