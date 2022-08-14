//
//  Header.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/15.
//

import Foundation
import UIKit
import Then
import SnapKit


class Header : UITableViewCell {
    let headerLabel = UILabel().then {
        $0.textColor = .willdWhite
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func layout() {
        [headerLabel].forEach {
            contentView.addSubview($0)
        }
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.bottom.equalToSuperview()
        }
    }
}
