//
//  ViewController.swift
//  Ex01AutoLayout
//
//  Created by 도학태 on 2022/07/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var isChange : Bool = false
    
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func changeLabel(_ sender: Any) {
        isChange = !isChange
        if isChange {
            label.text = "Hello IOS!"
            label.textColor = .blue
        }else {
            label.text = "Haktae with IOS"
            label.textColor = .green
        }
        
    }
    @IBAction func expressTF(_ sender: Any) {
        label2.text = tf.text
    }
}

