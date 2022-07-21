//
//  ViewController.swift
//  Ex02AutoLayoutCode
//
//  Created by 도학태 on 2022/07/12.
//

import UIKit

private let titleView : UILabel = UILabel()
private let idField : UITextField = UITextField()
private let pwField : UITextField = UITextField()
private let loginButton : UIButton = UIButton()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpMainLayout()
    }
    
    private func setUpMainLayout() {
        view.addSubview(titleView)
        view.addSubview(idField)
        view.addSubview(pwField)
        view.addSubview(loginButton)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        idField.translatesAutoresizingMaskIntoConstraints = false
        pwField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleView.backgroundColor = .systemPink
        titleView.text = "Service Login"
        titleView.font = .systemFont(ofSize: 24)
        titleView.textAlignment = .center

        idField.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16).isActive = true
        idField.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        idField.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        idField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        idField.backgroundColor = .white
        idField.placeholder = "Enter Your ID"

        pwField.topAnchor.constraint(equalTo: idField.bottomAnchor, constant: 16).isActive = true
        pwField.leadingAnchor.constraint(equalTo: idField.leadingAnchor).isActive = true
        pwField.trailingAnchor.constraint(equalTo: idField.trailingAnchor).isActive = true
        pwField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        pwField.backgroundColor = .white
        pwField.placeholder = "Enter Your PW"

        loginButton.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 16).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: pwField.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: pwField.trailingAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 10
        
        
        loginButton.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        
    
    }
    
    @objc func btnClicked() {
        let alert = UIAlertController(title: "Click!", message: "You Clicked that Button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    


}

