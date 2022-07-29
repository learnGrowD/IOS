//
//  ViewController.swift
//  Ex07Asynchronous
//
//  Created by 도학태 on 2022/07/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = DispatchQueue.main
        let b = DispatchQueue.global()
    
        print("DO")
        b.sync {
            for _ in 0..<10 {
                print("B")
            }
        }
        
        print("KK")
        b.sync {
            for _ in 0..<10 {
                print("A")
            }
        }
        
        
        b.async {
            for _ in 0..<10 {
                print("C")
            }
        }
        
        b.asyncAfter(deadline: .now() + 2) {
            print("DD")
        }
    }


}

