//
//  SearchBlogNetwork.swift
//  Ex12SearchDaumBlog
//
//  Created by 도학태 on 2022/08/01.
//

import Foundation
import RxSwift

enum SearchNetworkError : Error {
    case invalidURL
    case invalidJSON
    case networkError
}


class SearchBlogNetwork {
    private let session : URLSession
    let api = SaerchBlogAPI()
    
    init(session : URLSession = .shared) {
        self.session = session
    }
    
    func searchBlog(query : String) -> Single<Result<DKBlog, SearchNetworkError>> {
        guard let url = api.searchBlog(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 09a6c558f004ba62fb98f772cf1865dd", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                    .just(.failure(.networkError))
            }
            .asSingle()
            
    }
}
