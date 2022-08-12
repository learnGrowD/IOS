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
    let shouldPresentProgress : Driver<Bool>
//    let shouldPresentDetailData : Driver<[ChampionDetailPageSectionType]>
    
    init(
        champion : Observable<Champion>,
        _ detailRepository : DetailRepository = DetailRepository.instance) {
            
            self.shouldPresentProgress = detailRepository.championDetailData(champion: champion)
                .map { uiState -> Bool in
                    switch uiState {
                    case .loading:
                        return false
                    default:
                        return true
                    }
                }
                .asDriver(onErrorDriveWith: .empty())
            
    }
}
