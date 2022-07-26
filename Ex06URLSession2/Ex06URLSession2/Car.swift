//
//  Car.swift
//  Ex06URLSession2
//
//  Created by 도학태 on 2022/07/26.
//

import Foundation

struct CarParams : Encodable {
    let page : Int
    let _switch = true
    let sort = "Recent"
    let sType = ["1년 미만"]
    let sEvaluate = ["무심사"]
    let sSupplier = ["1년미만"]
    let sMinAge = [26]
    let sLocation = ["전체"]
    
    enum CodingKeys : String, CodingKey {
        case page = "Page"
        case _switch = "switch"
        case sType = "sType"
        case sEvaluate = "sEvaluate"
        case sSupplier = "sSupplier"
        case sMinAge = "sMinAge"
        case sLocation = "sLocation"
    }
}


struct Car : Decodable {
    let total : Int
    let carList : [CarItem]
    
    enum CodingKeys : String, CodingKey {
        case total = "Total"
        case carList = "List"
    }

}

struct CarItem : Decodable {
    let prodID : String?
    let companyLogoURL : String?
    let companyName : String?
    
    let carImgURL : String?
    let carTags : [CarTag]?
    let carModel : String?
    let carGrade : String?
    
    let carAgeYear : String?
    let carAgeMonth : String?
    let carMilage : String?
    let carFuel : String?
    
    let carOptions : [String]?
    
    let carPrice : Int?
    let carPeriod : Int?
    
    var carNaem : String {
        return (carModel ?? "") + " " + (carGrade ?? "")
    }

    var carMainInfo: String {
        return (carAgeYear ?? "") + "." + (carAgeMonth ?? "") + "·" + (carMilage ?? "") + "Km" + "·" + (carFuel ?? "")
    }

    var carSubInfo : String {
        var subOp = ""
        for i in 0..<(carOptions?.count ?? 0) {
            if i != (carOptions?.count ?? 0) - 1 {
                subOp = "\(carOptions?[i] ?? "")·"
            }else {
                subOp = "\(carOptions?[i] ?? "")"
            }
        }
        return subOp
    }

    var sellInfo : String {
        return "\(carPrice ?? 0)만원 / 월 \(carPeriod ?? 0)개월"
    }
    
    enum CodingKeys : String, CodingKey {
        case prodID = "ProdID"
        case companyLogoURL = "Logo"
        case companyName = "CompanyName"

        case carImgURL = "Cover"
        case carTags = "Tags"
        case carModel = "Model"
        case carGrade = "Grade"

        case carAgeYear = "AgeYear"
        case carAgeMonth = "AgeMonth"
        case carMilage = "Mileage"
        case carFuel = "Fuel"

        case carOptions = "Opts"
        case carPrice = "Price"
        case carPeriod = "Period"
    }
}

struct CarTag : Decodable {
    let name : String?
    let bgColor : String?
    let textColor : String?
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case bgColor = "bgcolor"
        case textColor = "color"
    }
}

