//
//  PlayerRankCollectionViewCell.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/17.
//

import Foundation
import RxSwift
import RxCocoa
import Then
import Kingfisher
import SnapKit
import UIKit


class PlayerRankCollectionViewCell : UICollectionViewCell {
    let disposeBag = DisposeBag()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        attribute()
        layout()
    }
    
    
    func bind(row : Observable<Int>, _ viewModel : PlayerLankViewModel) {
        let playerLank = row
            .flatMapLatest { row -> Driver<PlayerLank> in
                viewModel.playerRankList
                    .map { playerRankList in
                        playerRankList[row]
                    }
            }
//
//        playerLank
//            .bind(onNext : {
//                print($0)
//            })
//            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        
    }
}
