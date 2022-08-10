//
//  ChampionListViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/09.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


class ChampionListViewController : UIViewController {
    let disposeBag = DisposeBag()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(ChampionListViewCell.self, forCellWithReuseIdentifier: "ChampionListViewCell")
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel : ChampionListViewModel) {
        viewModel.shouldPresedentChampionList
            .drive(self.collectionView.rx.items) { cv, row, data in
                let index = IndexPath(row: row, section: 0)
                guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "ChampionListViewCell", for: index) as? ChampionListViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(data: data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
    }
    
    
    private func layout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
