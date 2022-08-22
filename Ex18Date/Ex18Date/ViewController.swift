//
//  ViewController.swift
//  Ex18Date
//
//  Created by 도학태 on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        let date = Date(timeIntervalSince1970: 1650705233)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "yyyy.MM.dd"
        let a = formatter.string(from: date)
        
        print(a)
        
        
        
        
    }


}

