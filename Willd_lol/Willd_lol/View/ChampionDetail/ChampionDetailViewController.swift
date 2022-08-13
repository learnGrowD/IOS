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
import SwiftUI


class ChampionDetailViewController : UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView().then {
        $0.dataSource = nil
        $0.delegate = nil
        $0.tableHeaderView = UIView()
        $0.tableFooterView = UIView()
        $0.backgroundColor = .willdBlack
        $0.rowHeight = 300
        $0.register(SkinsTableViewCell.self, forCellReuseIdentifier: "SkinsTableViewCell")
        $0.register(TagsTableViewCell.self, forCellReuseIdentifier: "TagsTableViewCell")
        $0.register(SkillsTableViewCell.self, forCellReuseIdentifier: "SkillsTableViewCell")
        $0.register(LoreTableViewCell.self, forCellReuseIdentifier: "LoreTableViewCell")
        $0.register(LankTableViewCell.self, forCellReuseIdentifier: "LankTableViewCell")
        $0.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
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
        viewModel.detailPageData
            .drive(tableView.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                switch row {
                case 0:
                    let cell = tv.dequeueReusableCell(withIdentifier: "SkinsTableViewCell", for: index) as! SkinsTableViewCell
                    cell.bind(viewModel.skinViewModel)
                    return cell
                case 1:
                    let cell = tv.dequeueReusableCell(withIdentifier: "TagsTableViewCell", for: index) as! TagsTableViewCell
                    cell.bind(viewModel.tagsViewModel)
                    return cell
                case 2:
                    let cell = tv.dequeueReusableCell(withIdentifier: "SkillsTableViewCell", for: index) as! SkillsTableViewCell
                    cell.bind(viewModel.skillsViewModel)
                    return cell
                case 3:
                    let cell = tv.dequeueReusableCell(withIdentifier: "LoreTableViewCell", for: index) as! LoreTableViewCell
                    cell.bind(viewModel.loreViewModel)
                    return cell
                case 4:
                    let cell = tv.dequeueReusableCell(withIdentifier: "LankTableViewCell", for: index) as! LankTableViewCell
                    cell.bind(viewModel.lankViewModel)
                    return cell
                case 5:
                    let cell = tv.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: index) as! CommentTableViewCell
                    cell.bind(viewModel.commentViewModel)
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
