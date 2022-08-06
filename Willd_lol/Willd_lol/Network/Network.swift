//
//  Network.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/06.
//

import Foundation
import RxSwift
import RxCocoa


enum NetWorkError : Error {
    case invalidURL
    case invalidJSON
    case networkError
}

class Network {
    private let session : URLSession
    let api = ApiService()
    
    init(session : URLSession = .shared) {
        self.session = session
    }
    
    func riotChampionList() -> Single<Result<Data, NetWorkError>> {
        guard let url = api.riotChampionList().url else {
            return .just(.failure(.invalidURL))
        }
        
        let requset = NSMutableURLRequest(url: url)
        requset.httpMethod = "GET"
        
        return session.rx.data(request: requset as URLRequest)
            .map { data in
                .success(data)
            }
            .catch { _ in
                .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    
    func abc(champion : String) -> Single<Result<Data, NetWorkError>> {
        guard let url = api.riotChampion(champion: champion).url else {
            return .just(.failure(.invalidURL))
        }
        
        let requset = NSMutableURLRequest(url: url)
        requset.httpMethod = "GET"
        
        return session.rx.data(request: requset as URLRequest)
            .map { data in
                .success(data)
            }
            .catch { _ in
                .just(.failure(.networkError))
            }
            .asSingle()
    }
}
