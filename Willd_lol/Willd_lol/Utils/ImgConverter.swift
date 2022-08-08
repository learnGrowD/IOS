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

struct ImgConverter {
    private static let baseUrl = "https://ddragon.leagueoflegends.com/cdn/"
    private static let championFullImgPath   = ImgConverter.baseUrl + "img/champion/splash/"
    private static let championMiddleImgPath = ImgConverter.baseUrl + "img/champion/loading/"
    private static let championSmallImgPath  = ImgConverter.baseUrl + "12.14.1/img/champion/"
    private static let passiveImgPath        = ImgConverter.baseUrl + "12.14.1/img/passive/"
    private static let spellImgPath          = ImgConverter.baseUrl + "12.14.1/img/spell/"
    
    static func convertChampionFullImgPath(
        type : ChampionImgType,
        championKey : String,
        skinIdentity : Int? = nil) -> URL? { // 0은 Default임...
            switch type {
            case .full:
                return URL(string: championFullImgPath + "\(championKey)_\(skinIdentity ?? 0).jpg")
            case .middle:
                return URL(string: championMiddleImgPath + "\(championKey)_\(skinIdentity ?? 0).jpg")
            case .small:
                return URL(string: championSmallImgPath + "\(championKey).png")
            }
    }
    
    static func convertPassiveImgPath(passiveIdentity : String) -> URL? {
        return URL(string: passiveImgPath + passiveIdentity)
    }
    
    static func convertSpellImgPath(
        chanpionKey : String,
        spellIdentity : String) -> URL? {
        return URL(string: spellImgPath + "\(chanpionKey)_\(spellIdentity)")
    }
}
