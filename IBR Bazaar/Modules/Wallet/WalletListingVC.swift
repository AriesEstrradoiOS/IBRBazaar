//
//  WalletListingVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 23/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class WalletListingVC:UIViewController{
    
    @IBOutlet var header: CommonHeader!
    @IBOutlet var topView: UIView!
    @IBOutlet var addMoneyButton: UIButton!
    
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
        header.backgroundColor = UIColor.clear
        header.titleLabel.text = "WALLET"
        addMoneyButton.layer.cornerRadius = 5
        topView.dropNarrowShadow(view: topView)
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
    }
}
