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
    let tableView = UITableView().then {
        $0.backgroundColor = .willdBlack
        $0.register(ChampionListViewCell.self, forCellReuseIdentifier: "ChampionListViewCell")
        $0.rowHeight = 100
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
        viewModel.shouldPresedentChampionPageData
            .drive(self.tableView.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: "ChampionListViewCell", for: index) as! ChampionListViewCell
                cell.configure(data: data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
    }
    
    
    private func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .willdBlack
////        title = "챔피언"
//
//        print("ChampionList -> viewDidLoad")
//    }
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        print("ChampionList -> viewWillLayoutSubviews")
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print("ChampionList -> viewDidLayoutSubviews")
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("ChampionList -> viewWillAppear")
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("ChampionList -> viewDidAppear")
//    }
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("ChampionList -> viewWillDisappear")
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("ChampionList -> viewDidDisappear")
//    }
    
}
