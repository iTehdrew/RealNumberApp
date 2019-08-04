//
//  CountryCell.swift
//  CountryList
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import UIKit

final class CountryCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var flagLabel: UILabel!
    @IBOutlet private var callsView: UIView!
    @IBOutlet private var smsView: UIView!
    
    // MARK: - Properties
    static let height: CGFloat = 50.0

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        callsView.layer.cornerRadius = 4.0
        smsView.layer.cornerRadius = 4.0
    }
}

// MARK: - Public methods
extension CountryCell {
    
    func configure(with country: Country) {
        titleLabel.text = country.name
        flagLabel.text = country.flag
        callsView.isHidden = !country.features.contains { $0 == .calls }
        smsView.isHidden = !country.features.contains { $0 == .sms }
    }
}
