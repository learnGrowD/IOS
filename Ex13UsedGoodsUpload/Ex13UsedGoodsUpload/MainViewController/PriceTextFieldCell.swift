//
//  PriceTextFieldCell.swift
//  Ex13UsedGoodsUpload
//
//  Created by 도학태 on 2022/08/02.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class PriceTextFieldCell : UITableViewCell {
    let disposeBag = DisposeBag()
    let priceInputField = UITextField().then {
        $0.keyboardType = .numberPad
        $0.font = .systemFont(ofSize: 17)
        
    }
    let freeshareButton = UIButton().then {
        $0.setTitle("무료나눔", for: .normal)
        $0.setTitleColor(.orange, for: .normal)
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18)
        $0.tintColor = .orange
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.orange.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 10.0
        $0.clipsToBounds = true
        $0.isHidden = true
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel : PriceTextFieldCellViewModel) {
        viewModel.showFreeShareButton
            .map { !$0 }
            .emit(to: freeshareButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.resetPrice
            .map { _ in "" }
            .emit(to: priceInputField.rx.text)
            .disposed(by: disposeBag)
        
        priceInputField.rx.text
            .bind(to: viewModel.priceValue)
            .disposed(by: disposeBag)
        
        freeshareButton.rx.tap
            .bind(to: viewModel.freeShareButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        [priceInputField, freeshareButton].forEach {
            contentView.addSubview($0)
        }
        
        priceInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        freeshareButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
    }
}
