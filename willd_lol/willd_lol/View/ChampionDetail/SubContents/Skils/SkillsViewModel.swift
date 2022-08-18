//
//  SkillsViewMOdel.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/13.
//

import Foundation
import RxCocoa
import RxSwift


struct SkillsViewModel {
    let disposeBag = DisposeBag()
    let skills = BehaviorRelay<[ChampionListApi.Champion.Skill]>(value: [])
    init(champion : Observable<Champion>,
         _ detailRepository : ChampionDetailRepository = ChampionDetailRepository.instance) {
        
        detailRepository.getSkills(champion: champion)
            .bind(to: skills)
            .disposed(by: disposeBag)
    }
}
