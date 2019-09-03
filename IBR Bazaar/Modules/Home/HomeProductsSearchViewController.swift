//
//  HomeProductsSearchViewController.swift
//  IBR Bazaar
//
//  Created by Monish M S on 23/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class HomeProductsSearchViewController:UIViewController,UISearchControllerDelegate{
    
    
    @IBOutlet var productsListingCollectionView: UICollectionView!
    @IBOutlet var header: CommonHeaderDeliveryAddress!
    @IBOutlet var productsSearchBar: UISearchBar!
    
    var productsList = ["50 50 Maska Chaska","Black Forest Cake","Ginger Biscuit","Unniyappam","20-20 Butter Cookies","Perotta","Mysore Pak","Breads","Chapathi","Burger"]
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupSearchBar()
    }
    
    func setupUI(){
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        header.backButton.isUserInteractionEnabled = true
        header.backButton.addGestureRecognizer(gesture)
        //productsListingCollectionView.register(UINib(nibName: "HomeShopsRecommendedItemsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeShopsRecommendedItemsCollectionViewCell")
        productsListingCollectionView.delegate = self
        productsListingCollectionView.dataSource = self
    }
    
    func setupCollectionView(){
        
    }
    
    func setupSearchBar(){
        productsSearchBar.delegate = self
        filteredData = productsList
        productsSearchBar.backgroundImage = UIImage()
        productsSearchBar.placeholder = "Search For Products"
        productsSearchBar.returnKeyType = .done
        productsSearchBar.enablesReturnKeyAutomatically = false
        productsSearchBar.becomeFirstResponder()
    }
    
    @objc func backButtonTapped(){
        self.view.removeFromSuperview()
    }
}

extension HomeProductsSearchViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsItemsCollectionViewCell", for: indexPath) as! ProductsItemsCollectionViewCell
        let color = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        cell.layer.borderColor = color.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.productName.text = filteredData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - 30
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomeProductsSearchViewController:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        productsSearchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            filteredData.removeAll()
            filteredData = productsList
        }else{
            let filtered  = productsList.filter{ $0.lowercased().contains(searchText.lowercased()) }
            filteredData = filtered
        }
        productsListingCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        productsSearchBar.enablesReturnKeyAutomatically = false
        productsSearchBar.resignFirstResponder()
    }
}


