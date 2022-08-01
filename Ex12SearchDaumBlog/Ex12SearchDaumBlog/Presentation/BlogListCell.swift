//
//  BlogListCell.swift
//  Ex12SearchDaumBlog
//
//  Created by 도학태 on 2022/08/01.
//

import UIKit
import RxCocoa
import RxSwift
import Then
import Kingfisher
import SnapKit

class BlogListCell : UITableViewCell {
    let thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
        
    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight : .bold)
    }
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 2
    }
    let dateTimeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight : .light)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [thumbnailImageView, nameLabel, titleLabel, dateTimeLabel].forEach {
            contentView.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8)
            $0.trailing.lessThanOrEqualTo(thumbnailImageView.snp.leading).offset(-8)
            
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8)
        }
        
        dateTimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(thumbnailImageView)
        }
        
    }
    
    func setData(_ data : BlogListCellData) {
        thumbnailImageView.kf.setImage(with: data.thumbnailURL, placeholder: UIImage(systemName: "photo"))
        nameLabel.text = data.name
        titleLabel.text = data.title
        
        var dateTime : String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let contentDate = data.dateTime ?? Date()
            
            return dateFormatter.string(from: contentDate)
        }
        
        dateTimeLabel.text = dateTime
    
    }
}

