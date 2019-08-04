//
//  FeatureListController.swift
//  CountryList
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import UIKit

protocol FeatureListControllerDelegate: AnyObject {
    func didScroll(to index: Int)
}

final class FeatureListController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Properties
    weak var delegate: FeatureListControllerDelegate?
    var features = [PurchaseFeature]()

    // MARK: - Lifecyclce
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let countryNib = UINib(nibName: String(describing: PurchaseFeatureCell.self), bundle: nil)
        collectionView.register(countryNib,
                                forCellWithReuseIdentifier: String(describing: PurchaseFeatureCell.self))
        
    }
}

// MARK: - UICollectionViewDataSource
extension FeatureListController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PurchaseFeatureCell.self),
                                                       for: indexPath) as? PurchaseFeatureCell else {
                                                        fatalError("Can't init reuseIdentifier")
        }
        let object = features[indexPath.row]
        cell.configure(with: object)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeatureListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

}

// MARK: - UIScrollViewDelegate
extension FeatureListController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let index = collectionView.indexPathsForVisibleItems.first?.row else {
            return
        }
        delegate?.didScroll(to: index)
    }
}
