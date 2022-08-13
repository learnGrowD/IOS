//
//  SkinCell.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Kingfisher



class SkinCell : UICollectionViewCell {
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(championSkinInfo : ChampionSkinInfo) {
        imageView.kf.setImage(with: ImageUrlConverter.convertChampionImgUrl(
            type: .full,
            championKey: championSkinInfo.championIdentity,
            skinIdentity: championSkinInfo.skinIdentity)
        )
    }
    
    func layout() {
        [imageView].forEach {
            contentView.addSubview($0)
        }
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
}
