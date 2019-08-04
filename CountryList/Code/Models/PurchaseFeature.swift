//
//  PurchaseFeature.swift
//  CountryList
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import UIKit

enum PurchaseFeature: Int, CaseIterable {
    case price
    case message
    
    var title: String {
        switch self {
        case .price:
            return NSLocalizedString("purchase_feature_call", comment: "")
        case .message:
            return NSLocalizedString("purchase_feature_additional", comment: "")
        }
    }
    
    var image: UIImage {
        switch self {
        case .price:
            return UIImage(named: "phoneCall")!
        case .message:
            return UIImage(named: "conversation")!
        }
    }
}
