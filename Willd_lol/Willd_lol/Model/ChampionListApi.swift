//
//  ChampionListApi.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/07.
//

import Foundation


struct ChampionListApi : Codable {
 
    let data : [Champion]
    
    struct Champion : Codable {
        let id : Int?
        let key : String?
        let name : String?
        let image_url : String?
        let passive : Passive
        let spells : [Spell]
        
        struct Passive : Codable {
            let name : String?
            let description : String?
            let image_url : String?
            let video_url : String?
        }
        
        struct Spell : Codable {
            let key : String?
            let name : String?
            let description : String?
            let tooltip : String?
            let image_url : String?
            let video_url : String?
        }
    }
}
