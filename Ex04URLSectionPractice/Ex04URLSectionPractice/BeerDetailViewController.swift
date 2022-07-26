//
//  BeerDetailViewController.swift
//  Ex04URLSectionPractice
//
//  Created by 도학태 on 2022/07/26.
//

import UIKit
import Then
import Kingfisher
import SnapKit

class BeerDetailViewController : UITableViewController {
    var beer : Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = beer?.name
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BeerDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let frame = CGRect(x: 0, y: 0, width: 0, height: 300)
        let header = UIImageView(frame: frame)
        header.contentMode = .scaleAspectFit
        header.kf.setImage(with: URL(string: beer?.imageURL ?? ""), placeholder: UIImage(named: "shark"))
        
        tableView.tableHeaderView = header
        
    }
}

extension BeerDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return beer?.foodPairing?.count ?? 0
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerDetailListCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = String(describing: beer?.id ?? 0)
            return cell
        case 1:
            cell.textLabel?.text = beer?.description ?? ""
            return cell
        case 2:
            cell.textLabel?.text = beer?.brewersTips ?? ""
            return cell
        case 3:
            cell.textLabel?.text = beer?.foodPairing?[indexPath.row] ?? ""
            return cell
        default:
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return "ID"
        case 1:
            return "Description"
        case 2:
            return "Brewers Tips"
        case 3:
            let isFoodPairingEmpty = beer?.foodPairing?.isEmpty ?? true
            return isFoodPairingEmpty ? nil : "Food Paring"
        default :
            return nil
        }
    }
}

