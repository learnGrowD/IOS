//
//  TierTagsCollectionViewCell.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/18.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Then
import SnapKit

class TierTagsCollectionViewCell : UICollectionViewCell {
    let disposeBag = DisposeBag()
    let tierLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    let laneLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        attribute()
        layout()
    }
    
    
    func bind(_ viewModel : TierTagViewModel) {
        viewModel.tier
            .map {
                switch $0 {
                case.etc:
                    return "브실골"
                case.platinum:
                    return "플레티넘"
                case.diamond:
                    return "다이아몬드"
                case.master:
                    return "마스터"
                }
            }
            .drive(self.tierLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.playerLane
            .map {
                switch $0 {
                case.top:
                    return "탑"
                case.jungle:
                    return "정글"
                case.mid:
                    return "미드"
                case.bottom:
                    return "바텀"
                case.supporter:
                    return "서포터"
                }
            }
            .drive(self.laneLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        [
            tierLabel,
            laneLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        tierLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        
        laneLabel.snp.makeConstraints {
            $0.leading.equalTo(tierLabel.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
        }
        
    }
}
