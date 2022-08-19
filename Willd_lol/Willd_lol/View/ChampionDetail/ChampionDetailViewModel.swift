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
    let skinViewModel : SkinsViewModel
    let tagsViewModel : TagsViewModel
    let skillsViewModel : SkillsViewModel
    let loreViewModel : LoreViewModel
    let lankViewModel : LankViewModel
    let commentViewModel : CommentViewModel
    
    let detailPageData : Driver<[ChampionDetailPageDataModel]>
    
    init(
        champion : Champion) {
            skinViewModel = SkinsViewModel(champion: champion)
            tagsViewModel = TagsViewModel(champion: champion)
            skillsViewModel = SkillsViewModel(champion: champion)
            loreViewModel = LoreViewModel(champion: champion)
            lankViewModel = LankViewModel(champion: champion)
            commentViewModel = CommentViewModel(champion: champion)
            
            
            self.detailPageData = Observable
                .combineLatest(
                    skinViewModel.skins.asObservable(),
                    tagsViewModel.tags.asObservable(),
                    skillsViewModel.skills.asObservable(),
                    loreViewModel.lore.asObservable(),
                    lankViewModel.lank.asObservable(),
                    commentViewModel.comment.asObservable()) { a, b, c, d, e, f -> [ChampionDetailPageDataModel] in
                        let result : [ChampionDetailPageDataModel] = [
                            .skins(nil, a),
                            .tags(nil, b),
                            .skills("Skills", c),
                            .lore("Story", d),
                            .playerLank("Rank", e),
                            .championComment("Comment", f)
                        ]
                        return result
                    }
                    .asDriver(onErrorDriveWith: .empty())
    }
}
