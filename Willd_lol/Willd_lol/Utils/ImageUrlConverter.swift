//
//  Converter.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/08.
//

import Foundation


enum ChampionImgType {
    case full
    case middle
    case small
}

struct ImageUrlConverter {
    private static let baseUrl = "https://ddragon.leagueoflegends.com/cdn/"
    private static let championFullImgPath   = ImageUrlConverter.baseUrl + "img/champion/splash/"
    private static let championMiddleImgPath = ImageUrlConverter.baseUrl + "img/champion/loading/"
    private static let championSmallImgPath  = ImageUrlConverter.baseUrl + "12.14.1/img/champion/"
    private static let passiveImgPath        = ImageUrlConverter.baseUrl + "12.14.1/img/passive/"
    private static let spellImgPath          = ImageUrlConverter.baseUrl + "12.14.1/img/spell/"
    
    static func convertChampionFullImgUrl(
        type : ChampionImgType,
        championKey : String?,
        skinIdentity : Int? = nil) -> URL? { // 0은 Default임...
            switch type {
            case .full:
                return URL(string: championFullImgPath + "\(championKey ?? "")_\(skinIdentity ?? 0).jpg")
            case .middle:
                return URL(string: championMiddleImgPath + "\(championKey ?? "")_\(skinIdentity ?? 0).jpg")
            case .small:
                return URL(string: championSmallImgPath + "\(championKey ?? "").png")
            }
    }
    
    static func convertPassiveImgUrl(passiveIdentity : String?) -> URL? {
        URL(string: passiveImgPath + (passiveIdentity ?? ""))
    }
    
    static func convertSpellImgUrl(spellIdentity : String?) -> URL? {
        URL(string: spellImgPath + (spellIdentity ?? ""))
    }
    
    
    static func convertImgUrl(_ imgPath : String?) -> URL? {
        URL(string: imgPath ?? "")
    }
}
