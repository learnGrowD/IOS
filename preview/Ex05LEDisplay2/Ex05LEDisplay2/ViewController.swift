//
//  ViewController.swift
//  Ex05LEDisplay2
//
//  Created by 도학태 on 2022/07/14.
//

import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {
    
    var textColor = UIColor.yellow
    var bgColor = UIColor.gray
    
    lazy var settingBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(title : "설정", style: .plain, target: self, action: #selector(tapSetting))
        btn.tag = 1
        return btn
    }()
    
    lazy var centerLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUIProperties(backgroundColor: bgColor, label: "Hatae IOS", labelColor: textColor)
        setConstraint()
        self.navigationItem.rightBarButtonItem = settingBtn
        
    }
    
    func setUIProperties(backgroundColor : UIColor, label : String, labelColor : UIColor) {
        view.backgroundColor = backgroundColor
        centerLabel.text = label
        centerLabel.textColor = labelColor
    }
    
    @objc func tapSetting() {
        let vc = SettingVC()
        vc.ledTf.text = centerLabel.text
        vc.textColorIdentity = textColor
        vc.bgColorIdentity = bgColor
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func changedSetting(text: String?, textColor: UIColor, backGroundColor: UIColor) {
        if let text = text {
            self.centerLabel.text = text
        }
        self.textColor = textColor
        self.centerLabel.textColor = textColor
        self.bgColor = backGroundColor
        self.view.backgroundColor = backGroundColor
        
    }
    
    func setConstraint() {
        view.addSubview(centerLabel)
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}

