//
//  ChampionCommentApi.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/07.
//

import Foundation


struct ChampionCommentApi : Codable {
    let data : [Comment]
    
    struct Comment : Codable {
        let id : Int?
        let content : String?
        let vote : Int?
        let version : String?
        let user : User
        let created_at : String?
        
        struct User : Codable {
            let level_name : String?
            let username : String?
        }
        
    }
}
