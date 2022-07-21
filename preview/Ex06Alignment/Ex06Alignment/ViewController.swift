//
//  ViewController.swift
//  Ex06Alignment
//
//  Created by 도학태 on 2022/07/15.
//

import UIKit

class ViewController: UIViewController {
    
    let veticalViewStack : UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 16
        stack.backgroundColor = .blue
        return stack
    }()

    let btn1 : UIButton = {
        let btn = UIButton(type: .system)
        setBtnUIProperty(btn: btn, color: .yellow)
        return btn
    }()

    let btn2 : UIButton = {
        let btn = UIButton(type: .system)
        setBtnUIProperty(btn: btn, color: .systemPink)
        return btn
    }()

    let btn3 : UIButton = {
        let btn = UIButton(type: .system)
        setBtnUIProperty(btn: btn, color: .systemGray)
        return btn
    }()
    

    let horizontalStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalCentering
        stack.spacing = 32
        return stack
    }()
    
    let btn4 : UIButton = {
        let btn = UIButton(type: .system)
        setBtnUIProperty(btn: btn, color: .systemBlue)
        return btn
    }()
    
    let btn5 : UIButton = {
        let btn = UIButton(type: .system)
        setBtnUIProperty(btn: btn, color: .systemCyan)
        return btn
    }()
    
    let btn6 : UIButton = {
        let btn = UIButton(type: .system)
        setBtnUIProperty(btn: btn, color: .systemMint)
        return btn
    }()
    
    
    let horizontalStack2 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalCentering
        stack.spacing = 32
        stack.backgroundColor = .black
        return stack
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        view.backgroundColor = .white
        
        let _ = [horizontalStack, horizontalStack2].map {
            veticalViewStack.addArrangedSubview($0)
        }
        
        let _ = [btn1, btn2, btn3].map {
            horizontalStack.addArrangedSubview($0)
        }
        
        let _ = [btn4, btn5, btn6].map {
            horizontalStack2.addArrangedSubview($0)
        }
        
        
    
    }
    
    func setConstraint() {
        view.addSubview(veticalViewStack)
        view.addSubview(horizontalStack2)
        
        NSLayoutConstraint.activate([
            veticalViewStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            veticalViewStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            veticalViewStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            veticalViewStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            horizontalStack2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            horizontalStack2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
        ])
        
    }
    
}

func setBtnUIProperty(btn : UIButton, color : UIColor) {
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.widthAnchor.constraint(equalToConstant: 64).isActive = true
    btn.heightAnchor.constraint(equalTo: btn.widthAnchor).isActive = true
    btn.layer.masksToBounds = true
    btn.layer.cornerRadius = 32
    btn.backgroundColor = color
}

