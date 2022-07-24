

import UIKit
import Then
import SnapKit
import Kingfisher

class BeerListCellTableViewCell: UITableViewCell {

    let beerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        
    }
    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 2
    }
    
    let taglineLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = .systemBlue
        $0.numberOfLines = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel, taglineLabel].forEach {
            contentView.addSubview($0)
        }
        
        beerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(beerImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        taglineLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
    }
    
    func configure(with beer : Beer) { //binding...
        let imageURL = URL(string: beer.imageURL ?? "")
        beerImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "shark"))
        nameLabel.text = beer.name ?? "이름 없는 맥주"
        taglineLabel.text = beer.tagLine
        
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }

}

