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
        champion : Observable<Champion>,
        _ detailRepository : DetailRepository = DetailRepository.instance) {
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
                            .skins(title: "스킨", a),
                            .tags(title: "태그", b),
                            .skills(title: "스킬", c),
                            .lore(title: "스토리", d),
                            .playerLank(title: "순위", e),
                            .championComment(title: "댓글", f)
                        ]
                        return result
                    }
                    .asDriver(onErrorDriveWith: .empty())
    }
}
