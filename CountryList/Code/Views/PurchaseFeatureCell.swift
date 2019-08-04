//
//  PurchaseFeatureCell.swift
//  CountryList
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import UIKit

final class PurchaseFeatureCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
}

// MARK: - Public methods
extension PurchaseFeatureCell {

    func configure(with object: PurchaseFeature) {
        titleLabel.text = object.title
        imageView.image = object.image
    }
}
