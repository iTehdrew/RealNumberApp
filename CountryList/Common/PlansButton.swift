//
//  PlansButton.swift
//  CountryList
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import UIKit

final class PlansButton: UIButton {
    
    // MARK: - Properties
    private var gradientLayer: CAGradientLayer?
    
    // MARK: - Lifecyclce
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tintColor = .clear
        
        let borderWith: CGFloat = 3.0
        let borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        layer.borderWidth = borderWith
        layer.borderColor = borderColor
    }
    
    override var isSelected: Bool {
        didSet {
            isSelected ? createGradient() : removeGradient()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
}

// MARK: - Private methods
extension PlansButton {
    
    func createGradient() {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: frame.size)
        gradient.colors = [#colorLiteral(red: 0.4274509804, green: 0.7568627451, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.1921568627, green: 0.5098039216, blue: 0.7058823529, alpha: 1).cgColor]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 10.0
        shape.path = UIBezierPath(rect: bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        layer.addSublayer(gradient)
        gradientLayer = gradient
    }
    
    func removeGradient() {
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
    }
}
