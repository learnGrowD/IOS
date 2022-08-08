//
//  UiState.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/07.
//

import Foundation

enum UiState<T> {
    case success(data : T)
    case alert(alertMsg : String)
    case loading
    case empty
}
