


import UIKit
import SnapKit
import Then

class RepositoryListCell: UITableViewCell {
    var repository : Repository?
    
    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight : .bold)
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight : .light)
        $0.numberOfLines = 2
    }
    
    let starImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star")
    }
    
    let starLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray
    }
    
    let languageLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [
            nameLabel, descriptionLabel,
            starImageView, starLabel, languageLabel
        ].forEach {
            contentView.addSubview($0)
        }

        
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(descriptionLabel)
            $0.width.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(18)
        }
        
        starLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        languageLabel.snp.makeConstraints {
            $0.centerY.equalTo(starLabel)
            $0.leading.equalTo(starLabel.snp.trailing).offset(12)
        }
        
    }
    
    func configure(repository : Repository?) {
        self.repository = repository
        nameLabel.text = repository?.name
        descriptionLabel.text = repository?.description
        starLabel.text = String(describing: repository?.stargazesCount)
        languageLabel.text = repository?.language
    }
    

}
