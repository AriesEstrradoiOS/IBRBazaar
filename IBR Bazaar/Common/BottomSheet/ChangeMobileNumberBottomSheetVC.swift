//
//  ChangeMobileNumberBottomSheetVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 02/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class ChangeMobileNumberBottomSheetVC:UIViewController{
    
    @IBOutlet var closeButtonView: UIView!
    @IBOutlet var mobileNumberTextField: TextField!
    @IBOutlet var generateOTPButton: UIButton!
    @IBOutlet var otpTextField: TextField!
    @IBOutlet var otpTextFieldHeight: NSLayoutConstraint!
    @IBOutlet var otpLabelHeight: NSLayoutConstraint!
    @IBOutlet var bottomSheetViewHeight: NSLayoutConstraint!
    @IBOutlet var generateOTPButtonHeight: NSLayoutConstraint!
    @IBOutlet var mobileNumberLabel: UILabel!
    @IBOutlet var otpLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func otpButtonTapped(_ sender: Any) {
        
    }
}
