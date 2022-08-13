//
//  SkinCollectionView.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Then
import SnapKit


class SkinsTableViewHeader : UITableViewCell {
//    let disposeBag = DisposeBag()
//    let a = UILabel().then {
//        $0.text = "HEllo"
//        $0.textColor = .willdWhite
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.backgroundColor = .willdBlack
//        contentView.addSubview(a)
//        a.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//
//    }
//
//    func bind(_ viewModel : SkinViewModel) {
//        viewModel.sholdPresentSkins
//            .drive(self.a.rx.text)
//            .disposed(by: disposeBag)
//    }
    let disposeBag = DisposeBag()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(SkinCell.self, forCellWithReuseIdentifier: "SkinCell")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func bind(_ viewModel : SkinsViewModel) {
        viewModel.sholdPresentSkins
            .drive(collectionView.rx.items) { cv, row, data in
                let indenx = IndexPath(row: row, section: 0)
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "SkinCell", for: indenx) as! SkinCell
                cell.configure(championSkinInfo: data)
                return cell
            }
            .disposed(by: disposeBag)
    }

    private func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func attribute() {
        collectionView.collectionViewLayout = generateLayout()
    }

    private func layout() {
        [collectionView].forEach {
            contentView.addSubview($0)
        }
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
    
}
