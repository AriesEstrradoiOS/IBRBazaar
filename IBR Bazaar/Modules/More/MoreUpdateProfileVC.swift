//
//  MoreUpdateProfileVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 23/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
class MoreUpdateProfileVC:UIViewController{
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet var editImageView: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet var houseNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var areaOrLocalityTextField: SkyFloatingLabelTextField!
    @IBOutlet var postTextField: SkyFloatingLabelTextField!
    @IBOutlet var stateTextField: SkyFloatingLabelTextField!
    @IBOutlet var mobileTextField: SkyFloatingLabelTextField!
    @IBOutlet var emailIdTextField: SkyFloatingLabelTextField!
    @IBOutlet var districtTextField: SkyFloatingLabelTextField!
    @IBOutlet var pincodeTextField: SkyFloatingLabelTextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var mainViewHeight: NSLayoutConstraint!
    @IBOutlet var header: CommonHeaderDeliveryAddress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        cameraView.layer.cornerRadius = 14.5
        let editGesture = UITapGestureRecognizer(target: self, action: #selector(editButtonTapped))
        editImageView.isUserInteractionEnabled = true
        disableTextFields()
        mainViewHeight.constant = 750
        editImageView.tag = 1
        editImageView.addGestureRecognizer(editGesture)
        header.deliveryAddress.text = "PROFILE"
        header.editButton.isHidden = true
        header.deliveryAddressLabel.isHidden = true
        header.deliveryAddressLabelHeight.constant = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        header.backButton.isUserInteractionEnabled = true
        header.backButton.addGestureRecognizer(tap)
    }
    
    @objc func editButtonTapped(_ gesture:UITapGestureRecognizer){
        print("editButtonTapped")
        if editImageView.tag == 0{
            editImageView.tag = 1
            disableTextFields()
            mainViewHeight.constant = 750
        }else{
            editImageView.tag = 0
            enableTextFields()
            mainViewHeight.constant = 800
        }
    }
    
    @objc func backButtonTapped(_ tap:UITapGestureRecognizer){
      self.navigationController?.popViewController(animated: false)
    }
    
    func disableTextFields(){
        nameTextField.isUserInteractionEnabled = false
        houseNameTextField.isUserInteractionEnabled = false
        areaOrLocalityTextField.isUserInteractionEnabled = false
        postTextField.isUserInteractionEnabled = false
        stateTextField.isUserInteractionEnabled = false
        mobileTextField.isUserInteractionEnabled = false
        emailIdTextField.isUserInteractionEnabled = false
        districtTextField.isUserInteractionEnabled = false
        pincodeTextField.isUserInteractionEnabled = false
        submitButton.isHidden = true
    }
    
    func enableTextFields(){
        nameTextField.isUserInteractionEnabled = true
        houseNameTextField.isUserInteractionEnabled = true
        areaOrLocalityTextField.isUserInteractionEnabled = true
        postTextField.isUserInteractionEnabled = true
        stateTextField.isUserInteractionEnabled = true
        mobileTextField.isUserInteractionEnabled = true
        emailIdTextField.isUserInteractionEnabled = true
        districtTextField.isUserInteractionEnabled = true
        pincodeTextField.isUserInteractionEnabled = true
        submitButton.isHidden = false
        nameTextField.becomeFirstResponder()
    }
}
