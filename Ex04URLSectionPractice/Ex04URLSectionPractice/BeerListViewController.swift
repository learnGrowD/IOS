//
//  BeerListViewController.swift
//  Ex04URLSectionPractice
//
//  Created by 도학태 on 2022/07/26.
//

import UIKit
import Then
import SnapKit

class BeerListViewController: UITableViewController {
    var beerList : [Beer] = []
    var dataTasks : [URLSessionTask] = []
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTableView()
        
        fetchBeer(of: currentPage)
        
    }
    
    func setNavigation() {
        title = "패캠브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setTableView() {
        tableView.register(BeerListTableViewCell.self, forCellReuseIdentifier: "BeerListTableViewCell")
        tableView.rowHeight = 150
        tableView.prefetchDataSource = self
    }

}

extension BeerListViewController : UITableViewDataSourcePrefetching {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListTableViewCell", for: indexPath) as? BeerListTableViewCell else {return UITableViewCell()}
        cell.configure(with: beerList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectBeer
        self.show(detailViewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        indexPaths.forEach {
            if ($0.row + 1) / 25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }
    }
}



extension BeerListViewController {
    func fetchBeer(of page : Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
        dataTasks.firstIndex(where: {$0.originalRequest?.url == url}) == nil else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("ERROR")
                return
            }
            
            switch response.statusCode {
            case(200...299): //성공
                self.beerList += beers
                self.currentPage += 1
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case(400...499): //클라이언트 에러
                print("ERROR : Client")
            case(500...599): // 서버에러
                print("ERROR : Server")
            default:
                print("ERROR")
            }
        }
                
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}
