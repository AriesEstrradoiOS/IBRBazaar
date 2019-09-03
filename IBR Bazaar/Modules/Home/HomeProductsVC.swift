//
//  HomeProductsVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class HomeProductsVC:UIViewController,UISearchControllerDelegate,PopularItemsProtocol,categorySelectedItemProtocol{
    
    @IBOutlet var header: CommonHeaderDeliveryAddress!
    @IBOutlet var productListingTable: UITableView!
    @IBOutlet var productsSearchBar: UISearchBar!
    @IBOutlet var categoriesView: UIView!
    @IBOutlet var filterView: UIView!
    
    var ItemsNameList = ["Boondi","Black Forest cake"]
    var BrandList = ["All","Wonder Cookies"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpSearchBar()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       // addMaskView()
//        let image = UIImage(named: "verification_bg.png")
//        let maskingImage = UIImage(named: "logo.png")
//        let img = maskImage(image: image!, mask: maskingImage!)
//        self.view.setUPBackGroundImage(mainView: self.view, image: img)
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        categoriesView.layer.cornerRadius = 15
        filterView.layer.cornerRadius = 15
        let categoryGesture = UITapGestureRecognizer(target: self, action: #selector(categoryViewTapped))
        categoriesView.isUserInteractionEnabled = true
        categoriesView.addGestureRecognizer(categoryGesture)
        let filterGesture = UITapGestureRecognizer(target: self, action: #selector(filterViewTapped))
        filterView.isUserInteractionEnabled = true
        filterView.addGestureRecognizer(filterGesture)
        
        //self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        header.backgroundColor = UIColor.clear
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deliveryAddressButtonTapped))
        header.deliveryAddress.isUserInteractionEnabled = true
        header.deliveryAddress.addGestureRecognizer(tapGesture)
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        header.backButton.isUserInteractionEnabled = true
        header.backButton.addGestureRecognizer(backGesture)
    }
   
    func addMaskView(){
        let _maskingImage = UIImage(named: "avatar")
        let _maskingLayer = CALayer()
        _maskingLayer.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: 100, height: 100)
        _maskingLayer.contents = _maskingImage?.cgImage
        self.view.layer.mask = _maskingLayer
    }
    
    func maskImage(image:UIImage, mask:(UIImage))->UIImage{
        
        let imageReference = image.cgImage
        let maskReference = mask.cgImage
        
        let imageMask = CGImage(maskWidth: maskReference!.width,
                                height: 100,
                                bitsPerComponent: maskReference!.bitsPerComponent,
                                bitsPerPixel: maskReference!.bitsPerPixel,
                                bytesPerRow: maskReference!.bytesPerRow,
                                provider: maskReference!.dataProvider!, decode: nil, shouldInterpolate: true)
        
        let maskedReference = imageReference!.masking(imageMask!)
        
        let maskedImage = UIImage(cgImage:maskedReference!)
        
        return maskedImage
    }
    
    func setUpSearchBar(){
        productsSearchBar.delegate = self
        productsSearchBar.backgroundImage = UIImage()
        productsSearchBar.placeholder = "Search For Products"
        productsSearchBar.enablesReturnKeyAutomatically = true
    }
    
    func setupTable(){
        productListingTable.register(UINib(nibName: "ProductsFilterCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductsFilterCategoryTableViewCell")
        productListingTable.register(UINib(nibName: "ProductsImageViewCell", bundle: nil), forCellReuseIdentifier: "ProductsImageViewCell")
        productListingTable.rowHeight = UITableView.automaticDimension
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        productListingTable.contentInset = insets
    }
    
    
    
    @objc func deliveryAddressButtonTapped(){
        self.performSegue(withIdentifier: "segueToHomeDeliveryAddressVC", sender: nil)
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func categoryViewTapped(){
        addpopOverVC(filterView: false)
    }
    
    @objc func filterViewTapped(){
        addpopOverVC(filterView: true)
     }
    
    func addpopOverVC(filterView:Bool){
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "HomeCategoryOrFilterVC") as! HomeCategoryOrFilterVC
        popupVC.isFilterVC = filterView
        popupVC.delegate = self
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)
    }
    
    func PopularItemSelectedAtIndex(tag:Int){
        print("tapped====\(tag)")
        self.performSegue(withIdentifier: "segueToProductDetailsFromListing", sender: nil)
    }
    
    func selectedItem(row:Int){
        print("row===\(row)")
        productListingTable.scrollToRow(at: IndexPath(row: NSNotFound, section: row+2), at: .bottom, animated: false)
    }
}

extension HomeProductsVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Most Popular"
        }else if section == 2{
            return "Sweet Items"
        }else if section == 3{
            return "Biscuit"
        }else if section == 4{
            return "Buiscut and cookie"
        }else if section == 5{
            return "Items"
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else if section == 2{
            return 2
        }else if section == 3{
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 8, y: 8, width: tableView.bounds.width, height: 31)
        myLabel.font = UIFont.boldSystemFont(ofSize: 13)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsImageViewCell", for: indexPath) as! ProductsImageViewCell
            cell.topView.dropShadow()
            cell.topView.layer.cornerRadius = 5
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeShopsPopularItemsTableViewCell", for: indexPath) as! HomeShopsPopularItemsTableViewCell
            cell.backgroundColor = UIColor.blue
            cell.delegate = self
            return cell
        }else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsFilterCategoryTableViewCell", for: indexPath) as! ProductsFilterCategoryTableViewCell
            if indexPath.section == 2{
              cell.itemName.text = ItemsNameList[indexPath.row]
            }else{
               cell.itemName.text = "Ginger Buiscut"
            }
            
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 80
        }
        else if indexPath.section == 1{
            return 100
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.1
        }
        return 51
    }
    
}


extension HomeProductsVC:UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    let storyBoard = UIStoryboard(name: "Home", bundle: nil)
    let popupVC = storyBoard.instantiateViewController(withIdentifier: "HomeProductsSearchViewController") as! HomeProductsSearchViewController
    self.addChild(popupVC)
    self.view.addSubview(popupVC.view)
    popupVC.didMove(toParent: self)
    return false
   }
}


