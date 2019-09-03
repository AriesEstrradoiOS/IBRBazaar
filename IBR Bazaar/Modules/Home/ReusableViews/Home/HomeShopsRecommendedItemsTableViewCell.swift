//
//  HomeShopsRecommendedItemsTableViewCell.swift
//  IBR Bazaar
//
//  Created by Monish M S on 19/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

protocol recommendedItemsProtocol {
    func recommendedItemSelectedAtIndex(tag:Int)
}

import Foundation
import UIKit
class HomeShopsRecommendedItemsTableViewCell:UITableViewCell{
    var cellHeight = 0
    var delegate: recommendedItemsProtocol?
}

extension HomeShopsRecommendedItemsTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeShopsRecommendedItemsCollectionViewCell", for: indexPath) as! HomeShopsRecommendedItemsCollectionViewCell
        let color = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        cell.layer.borderColor = color.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        // cell.dropShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellHeight, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendedItemSelectedAtIndex(tag: indexPath.row)
    }
}
