//
//  MoreOptionsVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 31/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class MoreOptionsVC:UIViewController{
    
    @IBOutlet var header: CommonHeader!
    @IBOutlet var moreOptionsTableView: UITableView!
    @IBOutlet var profileImage: UIImageView!
    
    var titleArray = ["Update Profile","Change Mobile Number (1111)","Call Customer Care","Privacy Policy","Change Delivery Address","Terms and Conditions","Frequently Asked Questions","Share IBR Bazaar Application"]
    let changeMobNobottomSheetVC = ChangeMobileNumberBottomSheetVC()
    let callCustomerCarebottomSheetVC = CallCustomerCareBottomSheetVC()
    let MobNobottomLine = CALayer()
    let otpbottomLine = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTable()
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func setupTable(){
        self.navigationController?.navigationBar.isHidden = true
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        moreOptionsTableView.register(UINib(nibName: "MoreOptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreOptionsTableViewCell")
        moreOptionsTableView.rowHeight = UITableView.automaticDimension
        moreOptionsTableView.reloadData()
    }
    
    func addChangeMobNoBottomSheetView() {
        self.addChild(changeMobNobottomSheetVC)
        changeMobNobottomSheetVC.view.inputAccessoryView?.backgroundColor = UIColor.clear
        changeMobNobottomSheetVC.generateOTPButton.addTarget(self, action: #selector(otpButtonTapped), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        changeMobNobottomSheetVC.closeButtonView.addGestureRecognizer(tap)
        self.view.addSubview(changeMobNobottomSheetVC.view)
        changeMobNobottomSheetVC.didMove(toParent: self)
        let height = self.view.frame.height
        let width  = self.view.frame.width
        changeMobNobottomSheetVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        changeMobNobottomSheetVC.mobileNumberTextField.delegate = self
        changeMobNobottomSheetVC.otpTextField.delegate = self
        changeMobNobottomSheetVC.mobileNumberTextField.text = ""
        changeMobNobottomSheetVC.otpTextField.text = ""
        addBottomLayers()
        changeMobNobottomSheetVC.closeButtonView.layer.cornerRadius = changeMobNobottomSheetVC.closeButtonView.frame.height/2
        changeMobNobottomSheetVC.bottomSheetViewHeight.constant = 220
        changeMobNobottomSheetVC.generateOTPButtonHeight.constant = 30
        changeMobNobottomSheetVC.otpTextFieldHeight.constant = 0
        changeMobNobottomSheetVC.otpLabelHeight.constant = 0
        changeMobNobottomSheetVC.otpTextField.isHidden = true
    }
    
    func addCustomerCareBottomSheetView() {
        self.addChild(callCustomerCarebottomSheetVC)
        callCustomerCarebottomSheetVC.view.inputAccessoryView?.backgroundColor = UIColor.clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(customerNumberTapped))
       callCustomerCarebottomSheetVC.customerCareNumberLabel.isUserInteractionEnabled = true
        callCustomerCarebottomSheetVC.customerCareNumberLabel.addGestureRecognizer(tap)
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(callCloseButtonTapped))
        callCustomerCarebottomSheetVC.closeButtonView.isUserInteractionEnabled = true
        callCustomerCarebottomSheetVC.closeButtonView.addGestureRecognizer(closeTap)
        self.view.addSubview(callCustomerCarebottomSheetVC.view)
        callCustomerCarebottomSheetVC.didMove(toParent: self)
        let height = self.view.frame.height
        let width  = self.view.frame.width
        callCustomerCarebottomSheetVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func addBottomLayers(){
        MobNobottomLine.frame = CGRect(x: 0.0, y: changeMobNobottomSheetVC.mobileNumberTextField.frame.height - 1, width:  UIScreen.main.bounds.width - 16, height: 2.0)
        MobNobottomLine.backgroundColor = UIColor.blue.cgColor
        changeMobNobottomSheetVC.mobileNumberTextField.borderStyle = .none
        changeMobNobottomSheetVC.mobileNumberTextField.layer.addSublayer(MobNobottomLine)
        
        otpbottomLine.frame = CGRect(x: 0.0, y: changeMobNobottomSheetVC.otpTextField.frame.height - 1, width:  UIScreen.main.bounds.width - 16, height: 2.0)
        otpbottomLine.backgroundColor = UIColor.lightGray.cgColor
        changeMobNobottomSheetVC.otpTextField.borderStyle = .none
        changeMobNobottomSheetVC.otpTextField.layer.addSublayer(otpbottomLine)
    }
    
    @objc func otpButtonTapped(_ button:UIButton){
        if changeMobNobottomSheetVC.mobileNumberTextField.text! == ""{
            showPopUp(message: "Phone number invalid")
        }else{
            changeMobNobottomSheetVC.bottomSheetViewHeight.constant = 250
            changeMobNobottomSheetVC.generateOTPButtonHeight.constant = 0
            changeMobNobottomSheetVC.otpLabelHeight.constant = 16
            changeMobNobottomSheetVC.otpTextFieldHeight.constant = 30
            changeMobNobottomSheetVC.otpTextField.isHidden = false
            
        }
    }
    
    @objc func customerNumberTapped(_ gesture:UITapGestureRecognizer){
        if let url = URL(string: "tel://\(callCustomerCarebottomSheetVC.customerCareNumberLabel.text!)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func showPopUp(message:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "IBR", oktitle:"Done", OkButtonBlock:{ (action)
            in
        })
        self.present(alert,animated: false,completion: nil)
    }
    
    @objc func closeButtonTapped(_ tap:UITapGestureRecognizer){
        self.tabBarController?.tabBar.isHidden = false
        changeMobNobottomSheetVC.view.removeFromSuperview()
    }
    
    @objc func callCloseButtonTapped(_tap:UITapGestureRecognizer){
        self.tabBarController?.tabBar.isHidden = false
        callCustomerCarebottomSheetVC.view.removeFromSuperview()
    }
    
    
    
}

extension MoreOptionsVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moreOptionsTableView.dequeueReusableCell(withIdentifier: "MoreOptionsTableViewCell") as! MoreOptionsTableViewCell
        cell.title.text = titleArray[indexPath.row]
        cell.profileImage.image = UIImage(named: "avatar")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
           self.performSegue(withIdentifier: "showSegueToMoreUpdateProfileVC", sender: nil)
        }else if indexPath.row == 1{
           addChangeMobNoBottomSheetView()
        }else if indexPath.row == 2{
            addCustomerCareBottomSheetView()
        }else if indexPath.row == 4{
            self.performSegue(withIdentifier: "segueFromMoreOptionsVCToHomeDeliveryAddressVC", sender: nil)
        }
    }
}

extension MoreOptionsVC:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == changeMobNobottomSheetVC.mobileNumberTextField{
            changeMobNobottomSheetVC.mobileNumberLabel.textColor = UIColor.blue
            MobNobottomLine.backgroundColor = UIColor.blue.cgColor
            otpbottomLine.backgroundColor = UIColor.lightGray.cgColor
            changeMobNobottomSheetVC.otpLabel.textColor = UIColor.lightGray
        }else if textField == changeMobNobottomSheetVC.otpTextField{
            changeMobNobottomSheetVC.mobileNumberLabel.textColor = UIColor.lightGray
            MobNobottomLine.backgroundColor = UIColor.lightGray.cgColor
            otpbottomLine.backgroundColor = UIColor.blue.cgColor
            changeMobNobottomSheetVC.otpLabel.textColor = UIColor.blue
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == changeMobNobottomSheetVC.otpTextField{
            if  textField.text!.count == 3{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setThisViewControllerWithIdentifierAsRoot(identifier: "MobileVerificationVC", InStoryBoard: "Main")
            }
        }
         return true
    }
}
