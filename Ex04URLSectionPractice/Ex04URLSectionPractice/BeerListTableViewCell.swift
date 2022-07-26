//
//  BeerListTableViewCell.swift
//  Ex04URLSectionPractice
//
//  Created by 도학태 on 2022/07/26.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class BeerListTableViewCell: UITableViewCell {
    let imgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 2
    }
    
    let tagLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = .systemBlue
        $0.numberOfLines = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        registContentView()
        constraintViews()
    }
    
    func configure(with beer : Beer) {
        let imagURL = URL(string: beer.imageURL ?? "")
        imgView.kf.setImage(with: imagURL, placeholder: UIImage(named: "shark"))
        nameLabel.text = beer.name ?? "이름없는 맥주"
        tagLabel.text = beer.tagLine
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    func registContentView() {
        [imgView, nameLabel, tagLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    
    func constraintViews() {
        imgView.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(120)
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(24)
            $0.centerY.equalTo(imgView.snp.centerY)
        }
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
    }
    


}
