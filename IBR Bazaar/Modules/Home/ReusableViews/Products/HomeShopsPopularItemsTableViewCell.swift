//
//  HomeShopsPopularItemsTableViewCell.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

protocol PopularItemsProtocol {
    func PopularItemSelectedAtIndex(tag:Int)
}

import Foundation
import UIKit
class HomeShopsPopularItemsTableViewCell:UITableViewCell{
    var delegate: PopularItemsProtocol?
}
extension HomeShopsPopularItemsTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeShopsPopularItemsCollectionViewCell", for: indexPath) as! HomeShopsPopularItemsCollectionViewCell
        let color = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        cell.layer.borderColor = color.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        cell.itemName.layer.shadowColor = UIColor.black.cgColor
        cell.itemName.layer.shadowRadius = 5.0
        cell.itemName.layer.shadowOpacity = 1.0
        cell.itemName.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.itemName.layer.masksToBounds = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.PopularItemSelectedAtIndex(tag: indexPath.row)
    }
}
