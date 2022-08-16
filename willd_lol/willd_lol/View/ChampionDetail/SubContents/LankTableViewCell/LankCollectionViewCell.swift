//
//  LankCell.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Kingfisher



class LankCollectionViewCell : UICollectionViewCell {
    let disposeBag = DisposeBag()
    let lankLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight : .bold)
    }
    let tierboerderImagView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    let tierLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 12)
    }
    
    let nameLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 12)
    }
    let profileImagView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }

    let winRate = UILabel().then {
        $0.textColor = .willdWhite
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 12)
    }
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
     
    func bind(index : IndexPath, _ viewModel : LankViewModel) {
        let row = Observable.just(index.row)
        
        let rank = row
            .flatMapLatest { row in
                viewModel.lank
                    .map {
                        $0[row]
                    }
            }
        rank
            .bind(onNext : { [weak self] in
                guard let self = self else { return }
                self.lankLabel.text =  String(describing: $0.rank ?? 0)
                self.tierboerderImagView.kf.setImage(with: ImageUrlConverter.convertImgUrl($0.summoner.leagueStats[0].tierInfo.borderImageUrl))
                self.tierLabel.text = $0.summoner.leagueStats[0].tierInfo.tier
                self.nameLabel.text = $0.summoner.name
                self.profileImagView.kf.setImage(with: ImageUrlConverter.convertImgUrl($0.summoner.profileImageUrl))
                guard let win = $0.summoner.leagueStats[0].win,
                      let lose = $0.summoner.leagueStats[0].lose else {
                    return
                }
                let winRate = win * 100 / (win + lose)
                
                self.winRate.text = "승률 : \(winRate)% (\(win + lose)판)"
            })
            .disposed(by: disposeBag)
     }
     
     private func attribute() {
         
     }
     
     private func layout() {
         [
            lankLabel,
            tierboerderImagView,
            tierLabel,
            nameLabel,
            profileImagView,
            winRate
         ].forEach {
             contentView.addSubview($0)
         }
         
         lankLabel.snp.makeConstraints {
             $0.centerY.equalTo(tierboerderImagView.snp.centerY)
             $0.trailing.equalTo(tierboerderImagView.snp.leading).offset(-12)
         }
         
         profileImagView.snp.makeConstraints {
             $0.edges.equalTo(tierboerderImagView).inset(10)
         }
         
         tierboerderImagView.snp.makeConstraints {
             $0.width.height.equalTo(80)
             $0.top.equalToSuperview()
             $0.centerX.equalToSuperview()
         }
         
         nameLabel.snp.makeConstraints {
             $0.top.equalTo(tierboerderImagView.snp.bottom).offset(8)
             $0.leading.equalTo(lankLabel.snp.leading).offset(16)
             $0.trailing.equalToSuperview().inset(12)
             
         }
         tierLabel.snp.makeConstraints {
             $0.top.equalTo(nameLabel.snp.bottom).offset(8)
             $0.leading.equalTo(lankLabel.snp.leading).offset(16)
             $0.trailing.equalToSuperview().inset(12)
             
         }
         winRate.snp.makeConstraints {
             $0.top.equalTo(tierLabel.snp.bottom).offset(8)
             $0.leading.equalTo(lankLabel.snp.leading).offset(16)
             $0.trailing.equalToSuperview().inset(12)
         }
         
     }
}
