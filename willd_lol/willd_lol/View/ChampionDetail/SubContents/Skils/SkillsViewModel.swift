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
    let skills : Driver<[ChampionListApi.Champion.Skill]>
    init(champion : Observable<Champion>,
         _ detailRepository : ChampionDetailRepository = ChampionDetailRepository.instance) {
        skills = detailRepository.getSkills(champion: champion)
            .asDriver(onErrorDriveWith: .empty())
    }
}
