//
//  CartInitialVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 16/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class CartInitialVC:UIViewController{
    
    @IBOutlet var header: CommonHeader!
    @IBOutlet var shopButton: UseButtons!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        shopButton.dropNarrowShadow(view: shopButton)
        header.backgroundColor = UIColor.clear
        header.titleLabel.text = "CART"
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
    }
    @IBAction func continueShoppingAction(_ sender: Any) {
        userDefaults.SET_USERDEFAULTS(user_language: true, objectValue: "fromCartVC")
        tabBarController?.selectedIndex = 0
    }
}
