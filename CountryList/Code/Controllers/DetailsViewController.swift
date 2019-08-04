//
//  DetailsViewController.swift
//  CountryList
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private var mostPopularView: UIView!
    @IBOutlet private var footerLabel: UILabel!
    @IBOutlet private var firstPlanButton: UIButton!
    @IBOutlet private var secondPlanButton: UIButton!
    @IBOutlet private var thirdPlanButton: UIButton!
    @IBOutlet private var plansButtons: [PlansButton]!
    @IBOutlet private var pageControl: UIPageControl!
    
    // MARK: - Properties
    private var purchaseFeatures = [PurchaseFeature.price,
                                    PurchaseFeature.message,
                                    PurchaseFeature.price,
                                    PurchaseFeature.message]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        footerLabel.text = NSLocalizedString("details_footer_label", comment: "")
        pageControl.numberOfPages = purchaseFeatures.count
        mostPopularView.layer.cornerRadius = mostPopularView.bounds.midY
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectPeriod(secondPlanButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "featureList",
            let controller = segue.destination as? FeatureListController {
            
            controller.delegate = self
            controller.features = purchaseFeatures
        }
    }
    
    @IBAction private func selectPeriod(_ sender: UIButton) {
        plansButtons.forEach {
            $0.isSelected = false
        }
        sender.isSelected = true
    }

    @IBAction private func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func showInfo(_ sender: UIButton) {
        guard let url = URL(string: "https://apple.com") else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension DetailsViewController: FeatureListControllerDelegate {
    
    func didScroll(to index: Int) {
        pageControl.currentPage = index
    }
}
