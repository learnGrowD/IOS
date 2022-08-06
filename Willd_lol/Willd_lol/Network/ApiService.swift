//
//  ApiService.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/06.
//

import Foundation
import Alamofire
import SwiftUI


struct ApiService {
    
    static let scheme = "https"
    static let riotHost = "ddragon.leagueoflegends.com"
    static let riotPath = "/cdn/12.14.1/data/ko_KR/"
    
    static let opGgHost = "www.op.gg"
    static let opGgPath = "/api/"
    
    static let yourGgHost = "api.your.gg"
    static let youtGgPath = "/kr/api/"
    
    static let psHost = "lol.ps"
    
    
    
    func riotChampionList() -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.riotHost
        components.path = ApiService.riotPath + "champion.json"
        
        return components
    }
    
    func riotChampion(champion : String) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.riotHost
        components.path = ApiService.riotPath + "champion/" + "\(champion).json"
        
        return components
    }
    
    func championList() -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.opGgHost
        components.path = ApiService.opGgPath + "meta/champions?hl=ko_KR"
            
        return components
    }
    
    
    func championCmmentCount(champion : String) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.opGgHost
        components.path = ApiService.opGgPath + "champions/\(champion)/comments/count"
            
        return components
    }
    
    func championComment(
        sort : ChampionComment,
        page : Int,
        listCount : Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.opGgHost
        components.path = ApiService.opGgPath + "champions/olaf/comments?sort=\(sort)&page=\(page)&limit=\(listCount)&is_latest_version=false"
        
        return components
    }
    
    func championGoodAtPlayerRank(
        champion : String,
        limit : Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.opGgHost
        components.path = ApiService.opGgPath + "rankings/champions/\(champion)?region=kr&limit=\(limit)"
        
        return components
    }
    
    func mmrRank() -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.yourGgHost
        components.path = ApiService.youtGgPath + "named-summoners/ranking?lang=ko"
            
        return components
    }
    
    func playerDetail(playerName : String) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.yourGgHost
        components.path = ApiService.youtGgPath + "profile/\(playerName)?lang=ko&matchCategory=&listMatchCategory="
            
        return components
    }
    
    func searchPreview(search : String) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.yourGgHost
        components.path = ApiService.youtGgPath + "search/summoners?lang=ko&q=\(search)"
            
        return components
    }
    
    func matchInfo(identity : Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.yourGgHost
        components.path = ApiService.youtGgPath + "match/\(identity)?lang=ko"
            
        return components
    }
    
    func championRecommend(identity : Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.psHost
        components.path = "/index_champ/"
            
        return components
    }
    
    func championTier(
        tier : RankTier,
        lane : PlayerLane,
        orderby : ChampionTierOrderBy,
        listCount : Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiService.scheme
        components.host = ApiService.psHost
        components.path = "/lol/get_lane_champion_tier_list/?tier=\(tier)&lane=\(lane)&order_by=\(orderby)&region=3&count=\(listCount)"
            
        return components
    }
    
    func championDetail() {
        
    }
    

}

enum PlayerLane : Int {
    case top = 0
    case jungle = 1
    case mid = 2
    case bottom = 3
    case supporter = 4
}


enum ChampionComment : String {
    case popular
    case recent
}
enum RankTier : Int {
    case etc = 1 // 브, 실, 골
    case platinum = 2
    case diamond = 13
    case master = 3
}

enum ChampionTierOrderBy : String {
    case topScore = "-op_score"
    case rowScore = "op_score"
    case topWinRate = "-win_rate"
    case rowWinRate = "win_rate"
    case topPickRate = "-pick_rate"
    case rowPickRate = "pick_rate"
    case topBanRate = "-ban_rate"
    case rowBanRate = "ban_rate"
    
}
