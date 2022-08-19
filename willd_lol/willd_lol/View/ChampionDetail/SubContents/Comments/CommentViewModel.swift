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
    let disposeBag = DisposeBag()
    let commentCount = BehaviorRelay<Int>(value: 0)
    let commentValue = BehaviorRelay<[ChampionCommentApi.Comment]>(value: [])
    
    let comment = BehaviorRelay<(commentCount : Int, comment : [ChampionCommentApi.Comment])>(value: (0, []))
    
    init(champion : Observable<Champion>,
         _ detailRepository : DetailRepository = DetailRepository()) {
        
        detailRepository.getCommentCount(champion: champion)
            .bind(to: commentCount)
            .disposed(by: disposeBag)
        
        detailRepository.getComment(champion: champion)
            .bind(to: commentValue)
            .disposed(by: disposeBag)
        
        
        Observable
            .combineLatest(
                commentCount.asObservable(),
                commentValue.asObservable()) {
                    (commentCount : $0, comment : $1)
                }
                .bind(to: comment)
                .disposed(by: disposeBag)

    }
    
}


