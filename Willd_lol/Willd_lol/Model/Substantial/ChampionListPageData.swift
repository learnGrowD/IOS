//
//  ChampionListData.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/09.
//

import Foundation


typealias Champion = ChampionListApi.Champion
struct ChampionListPageData : Codable {
    let listData : [Champion]
}
