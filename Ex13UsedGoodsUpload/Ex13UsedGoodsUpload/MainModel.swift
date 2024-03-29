//
//  MainModel.swift
//  Ex13UsedGoodsUpload
//
//  Created by 도학태 on 2022/08/02.
//

import Foundation


struct MainModel {
    func setAlert(errorMessage : [String]) -> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        return (title : title, message : message)
    }
}
