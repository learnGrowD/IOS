//
//  CommentViewModel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import RxCocoa
import RxSwift




struct CommentViewModel {
    let comment : Driver<(commentCount : Int, comment : [ChampionCommentApi.Comment])>
    
    init(champion : Observable<Champion>,
         _ detailRepository : DetailRepository = DetailRepository.instance) {
        let commentValue = detailRepository.getComment(champion: champion)
            
        let commentCount = detailRepository.getCommentCount(champion: champion)
        comment = Observable
            .combineLatest(
                commentCount,
                commentValue) { a, b in
                    return (commentCount : a, comment : b)
                }
                .asDriver(onErrorDriveWith: .empty())
    }
    
}


