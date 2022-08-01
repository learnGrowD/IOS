//
//  Repository.swift
//  Ex09GithubRxSwift
//
//  Created by 도학태 on 2022/08/01.
//

import Foundation

struct Repository : Decodable {
    let id : Int
    let name : String
    let description : String
    let stargazesCount : Int
    let language : String
    
    enum CoidingKeys : String, CodingKey {
        case id, name, description, language
        case stargazesCount = "stargazers_count"
    }
}
