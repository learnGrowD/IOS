//
//  ChampionDetailViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/11.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ChampionDetailViewController : UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView().then {
        $0.backgroundColor = .willdBlack
        $0.rowHeight = 100
        $0.register(SkinsTableViewHeader.self, forCellReuseIdentifier: "SkinCollectionViewCell")
    }
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel : ChampionDetailViewModel) {
        viewModel.shouldPresentDetailData
            .drive(tableView.rx.items) { tv, row, data in
                switch row {
                case 0:
                    let index = IndexPath(row: row, section: 0)
                    let cell = tv.dequeueReusableCell(withIdentifier: "SkinCollectionViewCell", for: index) as! SkinsTableViewHeader
                    cell.bind(viewModel.skinViewModel)
                    return cell
                default:
                    return UITableViewCell()
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    func attribute() {
        
    }
    
    func layout() {
        [tableView].forEach {
            view.addSubview($0)
        }
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
