//
//  MainViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/06.
//

import Foundation
import UIKit
import Then

//혼자서의 생명주기
//- 1. addSubView 할때
//관계를 가질떄 생명주기
//- 1. 화면전환 할때
//- 2. TabBarController에 의해서 화면전환 할때
//- 3. ContainerView와의 생명주기??

//ViewController LifeCycles
//1. init -> ViewController 객체 생성
//2. loadView -> View가 메모리에 올라갈때 호출
//3. viewDidLoad -> View가 메모리에 다 올라갔을때 호출
//4. ViewWillAppear -> VIew가 보여지기 시작할때 호출
//5. ViewDidAppear -> Viewe가 다 보여졌을때 호출
//viewWillLayoutSubViews
//viewDidLayoutSubViews
//6. ViewWillDisAppear - > View가 사라지기 시작할때 호출
//7. ViewDidDisAppear -> View가 다 사라지면 호출
//8. deinit -> ViewController 객체가 메모리에서 해제되면 호출

class MainTabBarController : UITabBarController {
    
    
    lazy var homeNc = generateNavController(
        vc: HomViewController(),
        title: "홈",
        image: UIImage(systemName: "house.fill")
    )
    
    lazy var championListVc = ChampionListViewController().then {
        let viewmodel = ChampionListViewModel()
        $0.bind(viewmodel)
    }
    lazy var championListNc = generateNavController(
        vc: championListVc,
        title: "챔피언",
        image: UIImage(systemName: "list.bullet")
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
    
    private func generateNavController(
        vc : UIViewController,
        title : String,
        image : UIImage?) -> UINavigationController {
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.willdWhite ?? .white]
        navController.tabBarItem.image = image
        return navController
    }

    private func attribute() {
        self.viewControllers = [homeNc, championListNc]
        let _ = tabBar.then {
            UITabBar.clearShadow()
            $0.layer.applyShadow(color: .white, alpha: 1, x: 0, y: 0, blur: 1)
            $0.tintColor = .willdPulple
            $0.unselectedItemTintColor = .willdWhite
            $0.backgroundColor = .willdBlack
        }
    }
}
extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}

extension UITabBar {
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
