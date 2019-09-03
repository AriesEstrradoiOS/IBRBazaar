//
//  HomeShopsTempVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 19/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class HomeShopsTempVC:UIViewController,UISearchControllerDelegate,distancePopOverProtocol,sliderImageProtocol,recommendedItemsProtocol{
    
    @IBOutlet var header: CommonHeaderDeliveryAddress!
    @IBOutlet var shopsListingTableView: UITableView!
    @IBOutlet var shopsSearchBar: UISearchBar!
    
    var bottomSheetVC = DeliveryBottomSheetViewController()
    var logoImages = [UIImage(named: "logo"),UIImage(named: "logo"),UIImage(named: "logo"),UIImage(named: "logo")]
    var remainHeight = 0
    var aspectRatio: CGFloat = 0
    var scrollViewDidScrollLastY: CGFloat = 0
    var isDequed:Bool = false
    var resultSearchController:UISearchController? = nil
    var locationSearchTable = LocationSearchTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTable()
        shopsSearchBar.delegate = self
        shopsSearchBar.backgroundImage = UIImage()
        shopsSearchBar.placeholder = "Search For Shops"
        shopsSearchBar.enablesReturnKeyAutomatically = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        let address = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        if !self.children.contains(self.bottomSheetVC) && address == "" {
            print("inside")
            addBottomSheetView()
        }else{
            if address != ""{
                bottomSheetVC.view.removeFromSuperview()
            }
        }
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        header.backgroundColor = UIColor.clear
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deliveryAddressButtonTapped))
        header.deliveryAddress.isUserInteractionEnabled = true
        header.deliveryAddress.addGestureRecognizer(tapGesture)
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        header.backButton.isUserInteractionEnabled = true
        header.backButton.addGestureRecognizer(backGesture)
    }
    
    func setupTable(){
        navigationController?.navigationBar.isHidden = true
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        shopsListingTableView.register(UINib(nibName: "SliderBaseViewTableViewCell", bundle: nil), forCellReuseIdentifier: "SliderBaseViewTableViewCell")
        shopsListingTableView.register(UINib(nibName: "StoresTableViewCell", bundle: nil), forCellReuseIdentifier: "StoresTableViewCell")
        shopsListingTableView.rowHeight = UITableView.automaticDimension
        let headerNib = UINib.init(nibName: "ShopsInDistanceViewHeaderFooter", bundle: nil)
        shopsListingTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "ShopsInDistanceViewHeaderFooter")
    }
    
    func addBottomSheetView() {
        self.addChild(bottomSheetVC)
        bottomSheetVC.view.inputAccessoryView?.backgroundColor = UIColor.clear
        bottomSheetVC.cancelButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        bottomSheetVC.deliveryButton.addTarget(self, action: #selector(deliveryButtonTapped), for: .touchUpInside)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        let height = self.view.frame.height
        let width  = self.view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    @objc func deliveryAddressButtonTapped(){
        self.performSegue(withIdentifier: "segueToHomeDeliveryAddressVC", sender: nil)
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func deliveryButtonTapped(){
        self.performSegue(withIdentifier: "segueToHomeDeliveryAddressVC", sender: nil)
    }
    
    func distancePopOverDismissed(){
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func sliderTappedImage(row:Int){
        print("tapped====\(row)")
        self.performSegue(withIdentifier: "segueToHomeProductListingVC", sender: nil)
    }
    
    func recommendedItemSelectedAtIndex(tag:Int){
        print("tapped====\(tag)")
        self.performSegue(withIdentifier: "segueToHomeProductDetailsVC", sender: nil)
    }
    
}

extension HomeShopsTempVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return ""
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0{
            return "Recommended Items"
        }else{
            return ""
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("viewforheaderinsection===")
        isDequed = true
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ShopsInDistanceViewHeaderFooter") as! ShopsInDistanceViewHeaderFooter
        headerView.headerView.layer.cornerRadius = 20
        headerView.shopsButton.isHidden = true
        let recognizer = UITapGestureRecognizer(target: self
            , action: #selector(floatViewTapped))
        headerView.headerView.isUserInteractionEnabled = true
        headerView.headerView.addGestureRecognizer(recognizer)
        headerView.shopsButton.addTarget(self, action: #selector(floatButtonTapped(_:)), for: .touchUpInside)
        return headerView
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 8, y: 8, width: tableView.bounds.width, height: 31)
        myLabel.font = UIFont.boldSystemFont(ofSize: 13)
        myLabel.text = self.tableView(tableView, titleForFooterInSection: section)

        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(myLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderBaseViewTableViewCell", for: indexPath) as! SliderBaseViewTableViewCell
            aspectRatio = (UIScreen.main.bounds.height) / 2
            let additionalComponents:CGFloat = ((self.navigationController?.navigationBar.bounds.height)!+(UIApplication.shared.statusBarView?.bounds.height)!+(self.tabBarController?.tabBar.bounds.height)!+38)
            aspectRatio = UIScreen.main.bounds.height - additionalComponents
            aspectRatio = aspectRatio/2
            cell.baseView.sliderBaseViewHeight.constant = aspectRatio
            remainHeight = Int(UIScreen.main.bounds.height - aspectRatio)
            cell.baseView.logoImages = logoImages as! [UIImage]
            cell.baseView.reloadSlidingView()
            cell.baseView.delegate = self
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeShopsRecommendedItemsTableViewCell", for: indexPath) as! HomeShopsRecommendedItemsTableViewCell
            cell.cellHeight = Int(aspectRatio)
            cell.backgroundColor = UIColor.blue
            cell.delegate = self
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoresTableViewCell", for: indexPath) as! StoresTableViewCell
            if indexPath.row == 0{
                cell.moreStoresLabelHeight.constant = 31
            }else{
                cell.moreStoresLabelHeight.constant = 0
            }
            return cell
        }
        
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            self.performSegue(withIdentifier: "segueToHomeProductListingVC", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }else if indexPath.section == 1{
            return aspectRatio
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2{
            return 51
        }
        return 0.00000
    
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 51
        }
        return 0.00000000
    }
    
    
    @objc func floatViewTapped(_ sender: UITapGestureRecognizer) {
        moveToParent()
    }
    
    @objc func floatButtonTapped(_ button:UIButton){
         moveToParent()
    }
    
    func moveToParent(){
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "ShopsWithinDistanceVC") as! ShopsWithinDistanceVC
        popupVC.delegate = self
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if shopsListingTableView.rectForHeader(inSection: 2).origin.y <= shopsListingTableView.contentOffset.y {
            print("Section Header I want is at top")
            let view = shopsListingTableView.headerView(forSection: 2) as! ShopsInDistanceViewHeaderFooter
            view.shopsButton.isHidden = false
            view.shopsButton.setTitle("shops in km", for: .normal)
            view.headerView.layer.cornerRadius = 20
            isDequed = false
          //  view.shopsinkmButton.isHidden = true
        }
        else{
            if (shopsListingTableView.contentOffset.y > 300){
                print("Section Header I want is at bottom")
                //let view = shopsListingTableView.viewWithTag(2) as! ShopsInDistanceViewHeaderFooter
                
                let view = shopsListingTableView.headerView(forSection: 2) as! ShopsInDistanceViewHeaderFooter
                view.shopsButton.setTitle("", for: .normal)
                view.shopsButton.isHidden = true
                view.headerView.layer.cornerRadius = 20
            }
        }
    }
    
    
    
}

extension HomeShopsTempVC:UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "HomeShopsSearchVC") as! HomeShopsSearchVC
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)
        return false
    }
}
