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
        $0.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        contentView.backgroundColor = .willdBlack
        contentView.addSubview(imagView)
        imagView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.center.equalToSuperview()
        }
    }
    
    func configure(data : ChampionListApi.Champion) {
        imagView.kf.setImage(with: ImageUrlConverter.convertImgUrl(data.imageUrl))
    }
    
    
}
