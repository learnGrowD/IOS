//
//  CarListTableVIewController.swift
//  Ex06URLSession2
//
//  Created by 도학태 on 2022/07/26.
//

import UIKit
import SwiftUI

class CarListTableVIewController: UITableViewController {
    var carList : [CarItem] = []
    var currentPage = 1
    var perPage = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTableView()
        fetchCarList(of: currentPage)
        
    }
    
    func setNavigation() {
        title = "Car"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setTableView() {
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: "CarTableViewCell")
        tableView.rowHeight = 200
        tableView.prefetchDataSource = self
    }

}

extension CarListTableVIewController : UITableViewDataSourcePrefetching {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as? CarTableViewCell else { return UITableViewCell()}
        cell.configure(with: carList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello IOS \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        indexPaths.forEach {
            if ($0.row + 1) / perPage + 1 == currentPage {
                self.fetchCarList(of: currentPage)
                print(currentPage)
            }
        }
    }
}

//data fetch
extension CarListTableVIewController {
    func fetchCarList(of page : Int) {
        guard let url = URL(string: "https://api.vancar.kr/APP/getCars"),
              let params = try? JSONEncoder().encode(CarParams(page: page)) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = params
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let cars = try? JSONDecoder().decode(Car.self, from: data) else {
                print("ERROR! \(error?.localizedDescription ?? "NOT REASON")")
                return
            }
            
            switch response.statusCode {
            case(200...299):
                print(cars.total)
                guard self.carList.count <= cars.total else { return }
                self.carList += cars.carList
                self.currentPage += 1
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case(400...499):
                print("ERROR Client")
            case(500...599):
                print("ERROR Server")
            default:
                print("ERROR")
            }
        }
        dataTask.resume()
        
    }
}
