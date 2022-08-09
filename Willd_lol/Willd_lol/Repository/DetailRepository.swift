//
//  DetailRepository.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/09.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailRepositoryProtocal {
//    func searchDetailData() -> PublishSubject<UiState<SearchDetailPageData>>
//    func championDetailData() -> PublishSubject<UiState<ChampionDetailPageData>>
//    func playerDetailData() -> PublishSubject<UiState<PlayerDetailPageData>>
//    func rankDetailData() -> PublishSubject<UiState<RankDetailPageData>>
}

class DetailRepository : DetailRepositoryProtocal {
    static let instance = DetailRepository()
    private let apiService : ApiService
    private init() {
        apiService = ApiService.instance
    }
    
    
    
//    func searchDetailData() -> PublishSubject<UiState<SearchDetailPageData>> {
//        <#code#>
//    }
//
//    func championDetailData() -> PublishSubject<UiState<ChampionDetailPageData>> {
//        <#code#>
//    }
//
//    func playerDetailData() -> PublishSubject<UiState<PlayerDetailPageData>> {
//        <#code#>
//    }
//
//    func rankDetailData() -> PublishSubject<UiState<RankDetailPageData>> {
//        <#code#>
//    }
    
}
