//
//  RiotChampion.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/07.
//

import Foundation

struct RiotChampionDetailApi : Codable {
    
    let version : String?
    let data : [Champion]
    
    
    struct Champion : Codable {
        let skins : [Skin]
        let lore : String?
        
        struct Skin : Codable {
            let id : String?
            let num : Int?
            let name : String?
            let chromas : Bool?
        }
    }
}
