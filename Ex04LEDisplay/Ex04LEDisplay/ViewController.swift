//
//  ViewController.swift
//  Ex04LEDisplay
//
//  Created by 도학태 on 2022/07/14.
//

import UIKit

class ViewController: UIViewController {
    lazy var leftButton : UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed))
        button.tag = 1
        return button
    }()
    
    lazy var rightButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "RightBtn", style: .plain, target: self, action: #selector(buttonPressed))
        button.tag = 2
        return button
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("back", for: .normal)
        button.configuration = .filled()
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setConstraint()
        view.backgroundColor = .white
        
        self.title = "NavigationVC"
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.navigationItem.rightBarButtonItem = self.rightButton
        
        
    }
    
    private func setConstraint() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    
    @objc private func buttonPressed() {
        print("Hello")
    }
    
    @objc private func backButtonPressed() {
        print("IOS")
        self.navigationController?.popViewController(animated: true)
    }


}

