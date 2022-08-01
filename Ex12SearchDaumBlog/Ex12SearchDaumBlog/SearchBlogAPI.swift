//
//  SearchBlogAPI.swift
//  Ex12SearchDaumBlog
//
//  Created by 도학태 on 2022/08/01.
//

import Foundation

struct SaerchBlogAPI {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "v2/search/"
    
    func searchBlog(query : String) -> URLComponents {
        var components = URLComponents()
        components.scheme = SaerchBlogAPI.scheme
        components.host = SaerchBlogAPI.host
        components.path = SaerchBlogAPI.path + "blog"
        
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
    
        return components
    }
}
