//
//  HomeShopsVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 06/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class HomeShopsVC:UIViewController{
   
    @IBOutlet var header: CommonHeaderDeliveryAddress!
    @IBOutlet var sliderCollection: SliderBaseView!
    @IBOutlet var recommendedCollectionView: UICollectionView!
    @IBOutlet var storesTableView: UITableView!
    @IBOutlet var sliderCollectionHeight: NSLayoutConstraint!
    @IBOutlet var rootStackView: UIStackView!
    @IBOutlet var storesTableViewHeight: NSLayoutConstraint!
    
    var bottomSheetVC = DeliveryBottomSheetViewController()
    var logoImages = [UIImage(named: "logo"),UIImage(named: "logo"),UIImage(named: "logo"),UIImage(named: "logo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        sliderCollection.logoImages = logoImages as! [UIImage]
        sliderCollection.reloadSlidingView()
        sliderCollection.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sliderCollection.endTimer()
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
    
    override func viewDidLayoutSubviews() {
        sliderCollection.sliderBaseViewHeight.constant = sliderCollection.frame.height-50
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        header.backgroundColor = UIColor.clear
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deliveryAddressButtonTapped))
        header.deliveryAddress.isUserInteractionEnabled = true
        header.deliveryAddress.addGestureRecognizer(tapGesture)
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        header.backButton.isUserInteractionEnabled = true
        header.backButton.addGestureRecognizer(gesture)
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        storesTableView.delegate = self
        storesTableView.dataSource = self
        storesTableView.separatorStyle = .none
        storesTableView.register(UINib(nibName: "StoresTableViewCell", bundle: nil), forCellReuseIdentifier: "StoresTableViewCell")
        
        //rootStackView.addArrangedSubview(storesTableView)
        
//        let table = MyTable(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "StoresTableViewCell")
//        table.dataSource = table
//        rootStackView.addArrangedSubview(table)
//        table.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
//        table.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0).isActive = true

    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func deliveryButtonTapped(){
        self.performSegue(withIdentifier: "segueToHomeDeliveryAddressVC", sender: nil)
    }
    
    @objc func deliveryAddressButtonTapped(){
        self.performSegue(withIdentifier: "segueToHomeDeliveryAddressVC", sender: nil)
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
    
    func dropShadow(scale: Bool = true,cell:ShopByRecommendedItemsCollectionViewCell) {
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: cell.bounds.size.width + shadowSize,
                                                   height: cell.bounds.size.height + shadowSize))
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowPath = shadowPath.cgPath
    }
}

extension HomeShopsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopByRecommendedItemsCollectionViewCell", for: indexPath) as! ShopByRecommendedItemsCollectionViewCell
        let color = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        cell.layer.borderColor = color.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
       // cell.dropShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = (self.view.bounds.height - ((self.tabBarController?.tabBar.frame.height)!+header.bounds.height+sliderCollection.bounds.height+(self.navigationController?.navigationBar.bounds.height)!))-57
        
        return CGSize(width: cellHeight, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToHomeProductDetailsVC", sender: nil)
    }
}

extension HomeShopsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoresTableViewCell", for: indexPath) as! StoresTableViewCell
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

