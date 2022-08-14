//
//  ChampionDetailApi.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/08.
//

import Foundation


struct ChampionDetailApi : Codable {
    let version : String?
    let data : Data
    
    
    struct Data : Codable {
        let champion : Champion
        
        struct Champion : Codable {
            let skins : [Skin]
            let lore : String?
            let tags : [String]
            let title : String?
            let id : String?
            let key : String?
            let name : String?
            let image : Image
            
            struct Skin : Codable {
                let id : String?
                let num : Int?
                let name : String?
                let chromas : Bool?
            }
            
            struct Image : Codable {
                let full : String?
            }
        }
        
    }

}


