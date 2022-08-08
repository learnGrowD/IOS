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
        let imageUrl : String?
        let passive : Passive
        let spells : [Spell]
        
        struct Passive : Codable {
            let name : String?
            let description : String?
            let imageUrl : String?
            let videoUrl : String?
            
            enum CodingKeys : String, CodingKey {
                case name, description
                case imageUrl = "image_url"
                case videoUrl = "video_url"
            }
        }
        
        struct Spell : Codable {
            let key : String?
            let name : String?
            let description : String?
            let tooltip : String?
            let imageUrl : String?
            let videoUrl : String?
            
            enum CodingKeys : String, CodingKey {
                case key, name, description, tooltip
                case imageUrl = "image_url"
                case videoUrl = "video_url"
            }
        }
        
        enum CodingKeys : String, CodingKey {
            case id, key, name, passive, spells
            case imageUrl = "image_url"
        }
    }
}
