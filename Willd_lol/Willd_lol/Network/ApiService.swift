//
//  ApiService.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/06.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire


class ApiService {
    static let instance = ApiService()
    private init() {}
    private static let scheme = "https://"
    private static let riotHost = "ddragon.leagueoflegends.com"
    private static let riotPath = "/cdn/12.14.1/data/ko_KR/"
    
    private static let opGgHost = "www.op.gg"
    private static let opGgPath = "/api/"
    
    private static let yourGgHost = "api.your.gg"
    private static let youtGgPath = "/kr/api/"
    
    private static let psHost = "lol.ps"
    
    
    func championDetail(champion : String) -> Single<ChampionDetailApi> {
        Observable.just(
            ApiService.scheme
            + ApiService.riotHost
            + ApiService.riotPath
            + "champion/\(champion).json"
        )
        .flatMap { url -> Observable<Data> in
            AF.request(
                url,
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: ["Content-Type":"application/json"]
            ).rx.data()
        }
        .map { data -> String in
            String(decoding: data, as: UTF8.self)
        }
        .map { oldJsondStr -> String in
            oldJsondStr.replacingOccurrences(of: "\"\(champion)\":{", with: "\"champion\":{")
        }
        .map { newJsonStr -> Data? in
            newJsonStr.data(using: .utf8)
        }
        .map { newData -> ChampionDetailApi in
            try JSONDecoder().decode(ChampionDetailApi.self, from: newData ?? Data())
        }
        .asSingle()
    }
    
    func championList() -> Single<ChampionListApi> {
        Observable.just(
            ApiService.scheme
            + ApiService.opGgHost
            + ApiService.opGgPath
            + "meta/champions"
        )
        .flatMap { url -> Observable<Data> in
            let params = [
                "hl" : "ko_KR"
            ]
            return AF.request(
                url,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default,
                headers: ["Content-Type":"application/json"]
            ).rx.data()
        }
        .map { data in
            try JSONDecoder().decode(ChampionListApi.self, from: data)
        }
        .asSingle()
    }
    
    
    func championCommentCount(champion : String) -> Single<ChampionCommentCountApi> {
        Observable.just(
            ApiService.scheme
            + ApiService.opGgHost
            + ApiService.opGgPath
            + "champions/\(champion)/comments/count"
        )
        .flatMap { url -> Observable<Data> in
            AF.request(
                url,
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: ["Content-Type":"application/json"]
            ).rx.data()
        }
        .map { data in
            try JSONDecoder().decode(ChampionCommentCountApi.self, from: data)
        }
        .asSingle()
    }
    
    func championComment(
        champion : String,
        sort : ChampionComment = .popular,
        page : Int = 1,
        listCount : Int = 10) -> Single<ChampionCommentApi> {
            Observable.just(
                ApiService.scheme
                + ApiService.opGgHost
                + ApiService.opGgPath
                + "champions/\(champion)/comments"
            )
            .flatMap { url -> Observable<Data> in
                let params = [
                    "sort" : sort.rawValue,
                    "page" : "\(page)",
                    "limit" : "\(listCount)",
                    "is_latest_version" : "\(false)"
                ]
                return AF.request(
                    url,
                    method: .get,
                    parameters: params,
                    encoding: URLEncoding.default,
                    headers: ["Content-Type":"application/json"]
                ).rx.data()
            }
            .map { data in
                try JSONDecoder().decode(ChampionCommentApi.self, from: data)
            }
            .asSingle()
    }
    
    func championGoodAtPlayerRank(
        champion : String,
        limit : Int = 5) -> Single<ChampionGoodAtPlayerApi> {
            
            Observable.just(
                ApiService.scheme
                + ApiService.opGgHost
                + ApiService.opGgPath
                + "rankings/champions/\(champion)"
            )
            .flatMap { url -> Observable<Data> in
                let params = [
                    "region" : "kr",
                    "limit" : "\(limit)"
                ]
                return AF.request(
                    url,
                    method: .get,
                    parameters: params,
                    encoding: URLEncoding.default,
                    headers: ["Content-Type":"application/json"]
                ).rx.data()
            }
            .map { data in
                try JSONDecoder().decode(ChampionGoodAtPlayerApi.self, from: data)
            }
            .asSingle()

    }
    
    func selectedPlayerMmrRank() -> Single<PlayerMmrRankApi> {
        
        Observable.just(
            ApiService.scheme
            + ApiService.yourGgHost
            + ApiService.youtGgPath
            + "named-summoners/ranking"
        )
        .flatMap { url -> Observable<Data> in
            let params = [
                "lang" : "ko",
            ]
            return AF.request(
                url,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default,
                headers: ["Content-Type":"application/json"]
            ).rx.data()
        }
        .map { data in
            try JSONDecoder().decode(PlayerMmrRankApi.self, from: data)
        }
        .asSingle()
    }
    
    func playerDetail(playerName : String) -> Single<PlayerDetailApi> {
        Observable.just(
            ApiService.scheme
            + ApiService.yourGgHost
            + ApiService.youtGgPath
            + "profile/\(playerName)"
        )
        .flatMap { url -> Observable<Data> in
            let params = [
                "lang" : "ko",
                "matchCategory" : "SoloRank",
                "listMatchCategory" : ""
            ]
            return AF.request(
                url,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default,
                headers: ["Content-Type":"application/json"]
            ).rx.data()
        }
        .map { data in
            try JSONDecoder().decode(PlayerDetailApi.self, from: data)
        }
        .asSingle()
    }
    
    func matchInfo(identity : Int) -> Single<MatchInfoApi> {
        Observable.just(
            ApiService.scheme
            + ApiService.yourGgHost
            + ApiService.youtGgPath
            + "match/\(identity)"
        )
        .flatMap { url -> Observable<Data> in
            let params = [
                "lang" : "ko"
            ]
            return AF.request(
                url,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default,
                headers: ["Content-Type":"application/json"]
            ).rx.data()
        }
        .map { data in
            try JSONDecoder().decode(MatchInfoApi.self, from: data)
        }
        .asSingle()
        
    }
    
    func playerSearchPreview(search : String) -> Single<[SearchPreview]> {
        Observable.just(
            ApiService.scheme
            + ApiService.yourGgHost
            + ApiService.youtGgPath
            + "search/summoners"
        )
        .flatMap { url -> Observable<Data> in
            let params = [
                "q" : search
            ]
            return AF.request(
                url,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default,
                headers: ["Content-Type":"application/json"]
            ).rx.data()
        }
        .map { data in
            try JSONDecoder().decode([SearchPreview].self, from: data)
        }
        .asSingle()
    }
    
    func championRecommend(page : Int = 1) -> Single<ChampionRecommendApi> {
        Observable.just(
            ApiService.scheme
            + ApiService.psHost
            + "/index_champ"
            
        )
        .flatMap { url -> Observable<Data> in
            let params = [
                "page" : "\(page)"
            ]
            return AF.request(
                url,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default,
                headers: ["Content-Type":"application/json"]
            ).rx.data()
        }
        .map { data in
            try JSONDecoder().decode(ChampionRecommendApi.self, from: data)
        }
        .asSingle()
    }
    
    func championTierList(
        tier : RankTier = .etc,
        lane : PlayerLane = .top,
        orderby : ChampionTierOrderBy = .topScore,
        listCount : Int = 10) -> Single<ChampionTierListApi> {
            Observable.just(
                ApiService.scheme
                + ApiService.psHost
                + "/lol/get_lane_champion_tier_list"
            )
            .flatMap { url -> Observable<Data> in
                let params = [
                    "tier" : "\(tier.rawValue)",
                    "lane" : "\(lane.rawValue)",
                    "order_by" : orderby.rawValue,
                    "region" : "3",
                    "count" : "\(listCount)"
                ]
                return AF.request(
                    url,
                    method: .get,
                    parameters: params,
                    encoding: URLEncoding.default,
                    headers: ["Content-Type":"application/json"]
                ).rx.data()
            }
            .map { data in
                try JSONDecoder().decode(ChampionTierListApi.self, from: data)
            }
            .asSingle()
        }

}

enum NetWorkError : Error {
    case invalidURL
    case invalidJSON
    case networkError
}

enum PlayerLane : Int {
    case top = 0
    case jungle = 1
    case mid = 2
    case bottom = 3
    case supporter = 4
}


enum ChampionComment : String {
    case popular = "popular"
    case recent = "recent"
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
