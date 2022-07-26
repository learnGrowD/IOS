//
//  CarTableViewCell.swift
//  Ex06URLSession2
//
//  Created by 도학태 on 2022/07/26.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class CarTableViewCell: UITableViewCell {
    
    let companyLogoImgView  = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.frame.width / 2
    }
    
    let companyNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .light)
        $0.textColor = .white
    }
    
    let carImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    let tagLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    let infoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    let carNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    let carMainInfo = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = .systemGray
    }
    
    let carSubInfo = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = .systemGray
        
    }
    
    let sellInfo = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        registStackView()
        registContentView()
        constraintViews()
        
    }
    
    func configure(with car : CarItem) {
        companyLogoImgView.kf.setImage(with: URL(string: car.companyLogoURL ?? ""), placeholder: UIImage(named: "shark"))
        companyNameLabel.text = car.companyName ?? "이름 없는 차"
        carImgView.kf.setImage(with: URL(string: car.carImgURL ?? ""), placeholder: UIImage(named: "shark"))
        tagLabel.text = car.carTags?[0].name ?? "Tag"
        carNameLabel.text = car.carNaem
        carMainInfo.text = car.carMainInfo
        carSubInfo.text = car.carSubInfo
        sellInfo.text = car.sellInfo
        
        selectionStyle = .none
    
    }
    
    func constraintViews() {
        carImgView.snp.makeConstraints {
            $0.width.equalTo(132)
            $0.height.equalTo(98)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
        }
        
        companyLogoImgView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.top.equalTo(carImgView).inset(12)
        }
        
        companyNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(companyLogoImgView.snp.centerY)
            $0.leading.equalTo(companyLogoImgView.snp.trailing).offset(12)
        }
        
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(carImgView.snp.bottom).offset(24)
            $0.leading.equalTo(carImgView.snp.leading)
        }
        
        infoStackView.snp.makeConstraints {
            $0.centerY.equalTo(carImgView.snp.centerY)
            $0.leading.equalTo(carImgView.snp.trailing).offset(24)
        }
        
        sellInfo.snp.makeConstraints {
            $0.centerY.equalTo(tagLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
    
    func registStackView() {
        [carNameLabel, carMainInfo, carSubInfo].forEach {
            infoStackView.addArrangedSubview($0)
        }
    }
    
    func registContentView() {
        [companyLogoImgView, companyNameLabel, carImgView, tagLabel, infoStackView, sellInfo].forEach {
            contentView.addSubview($0)
        }
    }

}
