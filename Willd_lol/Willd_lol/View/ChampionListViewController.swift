//
//  ChampionListViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/09.
//

import Foundation
import UIKit



class ChampionListViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .willdBlack
//        title = "챔피언"
        
        print("ChampionList -> viewDidLoad")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ChampionList -> viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ChampionList -> viewDidLayoutSubviews")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ChampionList -> viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ChampionList -> viewDidAppear")
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ChampionList -> viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ChampionList -> viewDidDisappear")
    }
    
}
