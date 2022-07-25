//
//  Content.swift
//  Ex03UICollectionView
//
//  Created by 도학태 on 2022/07/25.
//

import UIKit

//Codable -> Gson과 같은 친구인듯...
//1. Encodabel -> Model -> Json (write)
//2. Decodable -> Json -> Model (read)


struct Content : Decodable {
    let sectionType : SectionType
    let sectionName : String
    let contentItem : [Item]
    
    
    enum SectionType : String, Decodable {
        case basic
        case main
        case large
        case rank
    }
    
    struct Item : Decodable {
        let description : String
        let imageName : String
        
        var image : UIImage {
            return UIImage(named: imageName) ?? UIImage()
        }
    }
    
}


