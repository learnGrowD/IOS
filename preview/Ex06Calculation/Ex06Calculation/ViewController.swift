//
//  ViewController.swift
//  Ex06Calculation
//
//  Created by 도학태 on 2022/07/15.
//

import UIKit

class ViewController: UIViewController {
    var calculationIdentity = -1 // -1 : none, 0 : 나누기, 1 : *, 2 : -, 3: +
    var resultNum : String = ""
    var addSomeNum : String = ""
    
    
    let result : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 64).isActive = true
        label.text = "0"
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    let veticalStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    lazy var btns1 = [
        getCommonButton(title: "AC", background: .systemBlue, selector: #selector(tapInit)),
        getYellowCircleButton(title: "+", selector: #selector(tapCalculation(identity:)))
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
    
    }
    
    
    func getHorizontalStackView(list : [UIButton]) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        let _ = list.map {
            stack.addArrangedSubview($0)
        }
        return stack
    }
    
    func getCommonButton(title : String, background : UIColor, selector : Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = background
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
    
    func getGrayCircleButton(title : String, selector : Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = .gray
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
    
    func getYellowCircleButton(title : String, selector : Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = .yellow
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
    
    @objc func tapNumberElement(element : String) {
        
    }
    
    @objc func tapCalculation(identity : UIButton) {
        
    }
    
    @objc func tapResult() {
    
        
    }
    
    @objc func tapInit() {
        
    }
    
    func setConstraint() {
        view.addSubview(result)
        
        NSLayoutConstraint.activate([
            result.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 144),
            result.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            result.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
    



}

