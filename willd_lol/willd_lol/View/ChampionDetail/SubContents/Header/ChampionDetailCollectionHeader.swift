//
//  DetailDefaultCollectionHeader.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/15.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then


class ChampionDetailCollectionHeader : UICollectionReusableView {
    let sectionNameLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title : String?) {
        sectionNameLabel.text = title
    }
    
    private func layout() {
        [sectionNameLabel].forEach {
            addSubview($0)
        }
        
        sectionNameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
    }
}
