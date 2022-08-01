//
//  FillterView.swift
//  Ex12SearchDaumBlog
//
//  Created by 도학태 on 2022/08/01.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit
import Then


class FillterVIew : UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    
    let soutButton = UIButton()
    let bottomBorder = UIView()
    
    //FillterView 외부에서 관찰
    let sortBUttonTapped = PublishRelay<Void>()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bind() {
        soutButton.rx.tap
            .bind(to: sortBUttonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        soutButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        bottomBorder.backgroundColor = .lightGray
    }
    
    private func layout() {
        [soutButton, bottomBorder].forEach {
            addSubview($0)
        }
        
        soutButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(28)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.top.equalTo(soutButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
