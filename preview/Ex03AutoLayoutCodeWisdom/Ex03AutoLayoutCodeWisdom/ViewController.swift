//
//  ViewController.swift
//  Ex03AutoLayoutCodeWisdom
//
//  Created by 도학태 on 2022/07/12.
//

import UIKit

private let header : UILabel = UILabel()
private let contentContainer : UIView = UIView()
private let wisdom : UILabel = UILabel()
private let name : UILabel = UILabel()
private let clickBtn : UIButton = UIButton()
let wisdomStr = [
    Wisdom(content: "사랑으로 행해진 일은 언제나 선악을 초월한다.", name: "프레드리히 니체"),
    Wisdom(content: "사랑은 우리가 원해서 피우는 폭발하는 시가이다.", name: "린다 배리"),
    Wisdom(content: "사랑은 지성에 대한 상상력의 승리다.", name: "헨리 루이스 멩켄"),
    Wisdom(content: "사랑은 자신 이외에 다른 것도 존재한다는 사실을 어렵사리 깨닫는 것이다.", name: "아이리스 머독"),
    Wisdom(content: "사랑은 결정이 아니다. 사랑은 감정이다. 누구를 사랑할지 결정할 수 있다면 훨씬 더 간단하겠지만 마법처럼 느껴지지는 않을 것이다.", name: "트레이 파커"),
    Wisdom(content: "사랑은 아름다운 여자를 만나서부터 그녀가 꼴뚜기처럼 생겼음을 발견하기까지의 즐거운 시간이다.", name: "존 배리모어"),
]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(header)
        view.addSubview(contentContainer)
        view.addSubview(wisdom)
        view.addSubview(name)
        view.addSubview(clickBtn)
    
        
        header.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        wisdom.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        clickBtn.translatesAutoresizingMaskIntoConstraints = false
        

        
        
        header.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        header.text = "명언 생성기"
        header.font = .systemFont(ofSize: 24)
        header.textAlignment = .center
        header.textColor = .blue
        
        contentContainer.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 24).isActive = true
        contentContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        contentContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        contentContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        contentContainer.backgroundColor = .systemGray
        contentContainer.alpha = 0.3
        contentContainer.layer.cornerRadius = 10
        
        wisdom.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 16).isActive = true
        wisdom.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 16).isActive = true
        wisdom.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -16).isActive = true
        wisdom.heightAnchor.constraint(equalToConstant: 120).isActive = true
        wisdom.text = "명언생성"
        wisdom.textColor = .white
        wisdom.textAlignment = .center
        wisdom.font = .systemFont(ofSize: 16)
    
        name.topAnchor.constraint(equalTo: wisdom.bottomAnchor, constant: 24).isActive = true
        name.leadingAnchor.constraint(equalTo: wisdom.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: wisdom.trailingAnchor).isActive = true
    
        name.text = "이름"
        name.textColor = .black
        name.textAlignment = .center
        name.font = .boldSystemFont(ofSize: 16)
        
        clickBtn.topAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: 24).isActive = true
        clickBtn.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        clickBtn.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        clickBtn.setTitle("명언생성", for: .normal)
        clickBtn.titleColor(for: .normal)
        clickBtn.addTarget(self, action: #selector(createWisdom), for: .touchUpInside)
        
        
    
    }
    
    @objc func createWisdom() {
        let random = Int.random(in: 0...5)
        wisdom.text = wisdomStr[random].content
        name.text = wisdomStr[random].name
    }


}

