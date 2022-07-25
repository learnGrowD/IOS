//
//  ContentCollectionViewMainCell.swift
//  Ex03UICollectionView
//
//  Created by 도학태 on 2022/07/25.
//

import UIKit
import Then
import SnapKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    let menuBackStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 20
    }
    
    let tvBtn = UIButton().then {
        $0.setTitle("TV 프로그램", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    let movieBtn = UIButton().then {
        $0.setTitle("영화", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    let catagoryBtn = UIButton().then {
        $0.setTitle("카테고리", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    let baseStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 20
        
    }
    
    let mainImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    let contentStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalCentering
        $0.spacing = 20
    }
    
    let plusBtn = UIButton().then {
        $0.setTitle("내가 찜한 콘텐츠", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    let playBtn = UIButton().then {
        $0.setTitle("재생", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        
    }
    
    let infoBtn = UIButton().then {
        $0.setTitle("정보", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        registContentView()
        registStackView()
        constraintView()
    }
    
    func registStackView() {
        [mainImg, descriptionLabel, contentStack].forEach {
            baseStack.addArrangedSubview($0)
        }
        
        
        [tvBtn, movieBtn, catagoryBtn].forEach {
            menuBackStack.addArrangedSubview($0)
        }
    
        
        [plusBtn, playBtn, infoBtn].forEach {
            contentStack.addArrangedSubview($0)
        }
    }

    
    func registContentView() {
        [baseStack, menuBackStack].forEach {
            contentView.addSubview($0)
        }
    }
    
    func constraintView() {
        
        mainImg.snp.makeConstraints {
            $0.width.trailing.leading.top.equalToSuperview()
            $0.height.equalTo(300)
        }
        menuBackStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        baseStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    
    
}
