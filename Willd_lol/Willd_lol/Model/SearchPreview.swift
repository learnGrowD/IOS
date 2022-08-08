//
//  PlayerSearchPreviewApi.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/07.
//

import Foundation


struct SearchPreview : Codable {
    let imageUrl : String?
    let lp : Int?
    let name : String?
    let tier : String?
}
