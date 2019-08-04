//
//  Country.swift
//  CountryList
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import Foundation

enum Feature: String {
    case calls
    case sms
    
    var title: String {
        switch self {
        case .calls:
            return NSLocalizedString("countryList_calls_label", comment: "").uppercased()
        case .sms:
            return NSLocalizedString("countryList_sms_label", comment: "").uppercased()
        }
    }
}

struct Country: Decodable {

    let id: Int
    let name: String
    let flag: String // used emoji as Flag
    private let featureList: [String]
    var features: [Feature] {
        return featureList.compactMap { Feature(rawValue: $0) ?? .calls }
    }
}
