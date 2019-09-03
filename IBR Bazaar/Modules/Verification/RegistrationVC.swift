//
//  RegistrationVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/06/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
class RegistrationVC:UIViewController,UITextFieldDelegate{
    
    @IBOutlet var middleView: UseViews!
    @IBOutlet var mobileNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet var referalCodeTextField: SkyFloatingLabelTextField!
    @IBOutlet var backButton: UIImageView!
    
    var mobileNumber:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        nameTextField.delegate = self
        nameTextField.placeholder = "Name*"
        nameTextField.titleFormatter = { $0 }
        mobileNumberTextField.placeholder = "Mobile Number"
        mobileNumberTextField.titleFormatter = { $0 }
        referalCodeTextField.placeholder = "Referal Code"
        referalCodeTextField.titleFormatter = { $0 }
        mobileNumberTextField.text = mobileNumber
        mobileNumberTextField.isUserInteractionEnabled = false
        let backbuttonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backbuttonGestureRecognizer)
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        middleView.dropShadow()
    }
    
    @objc func backButtonTapped(){
        print("tapped")
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        if nameTextField.text! == ""{
            showPopUp(message: "Please fill all mandatory fields")
        }else{
            userDefaults.SET_USERDEFAULTS(user_language: true, objectValue: "loginComplete")
            userDefaults.SET_USERDEFAULTS(user_language: "", objectValue: "deliveryAddress")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.settabbarRootVC()
        }
    }
    
    func showPopUp(message:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "IBR", oktitle:"Done", OkButtonBlock:{ (action)
            in
            self.nameTextField.becomeFirstResponder()
        })
        self.present(alert,animated: false,completion: nil)
    }
    
}
