//
//  ContentCollectionViewMainCell.swift
//  Ex01Snapkit
//
//  Created by 도학태 on 2022/07/22.
//

import UIKit

class ContentCollectionViewMainCell : UICollectionViewCell {
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    let tvButton = UIButton()
    let movieButton = UIButton()
    let categoryButton = UIButton()
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        //base StackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fill
        baseStackView.spacing = 5
        
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        //ImageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
            
        }
        
        //descriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        //contentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        [playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        plusButton.setTitle("내차 찜한 콘텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(tvButtonTap(sender:)), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(tvButtonTap(sender:)), for: .touchUpInside)
        
        
        contentStackView.addArrangedSubview(playButton)
        playButton.setTitle("재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        
        playButton.addTarget(self, action: #selector(tvButtonTap(sender:)), for: .touchUpInside)
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        
        //menuStackView
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        [tvButton, movieButton, categoryButton].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리", for: .normal)
        
        tvButton.addTarget(self, action: #selector(tvButtonTap(sender:)), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(tvButtonTap(sender:)), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(tvButtonTap(sender:)), for: .touchUpInside)
        
        menuStackView.snp.makeConstraints( {
            $0.top.equalTo(baseStackView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(30)
        })
    
    }
    
    @objc func tvButtonTap(sender : UIButton) {
        print("TEST ; TV Button Tap")
    }
}
