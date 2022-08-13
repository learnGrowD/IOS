//
//  ChampionDetailViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/12.
//

import Foundation
import RxSwift
import RxCocoa
import Then



struct ChampionDetailViewModel {
    let disposeBag = DisposeBag()
    let skinViewModel = SkinsViewModel()
    let shouldPresentDetailData : Driver<[[ChampionSkinInfo]]>
    
    init(
        champion : Observable<Champion>,
        _ detailRepository : DetailRepository = DetailRepository.instance) {
            
            let aaa = detailRepository.getSkins(champion: champion)
            
            aaa
                .bind(to : skinViewModel.skinValue)
                .disposed(by: disposeBag)
            
            shouldPresentDetailData =  aaa
                .map {
                    [$0]
                }
                .asDriver(onErrorDriveWith: .empty())
            
    }
}
