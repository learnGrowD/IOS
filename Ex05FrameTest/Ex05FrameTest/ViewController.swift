//
//  ViewController.swift
//  Ex05FrameTest
//
//  Created by 도학태 on 2022/07/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        
        let label = UILabel(frame: CGRect(origin: CGPoint(x: 100, y : 100), size: CGSize(width: 100, height: 100))
        label.backgroundColor = .systemPink
        label.textAlignment = .center
        label.text = "Hello"
        
        view.addSubview(label)
    
    }


}

