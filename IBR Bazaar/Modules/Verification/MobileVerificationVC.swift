//
//  MobileVerificationVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/06/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

class MobileVerificationVC:UIViewController{
    
    
    @IBOutlet var mobileNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet var middleView: UseViews!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        middleView.dropShadow()
    }
    
    func setupUI(){
         self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
    }
    
    @IBAction func otpSubmissionAction(_ sender: Any) {
        if mobileNumberTextField.text! == ""{
            showPopUp(message: "Phone number invalid")
        }else{
           self.performSegue(withIdentifier: "segueToOTPScene", sender: nil)
        }
    }
    
    func showPopUp(message:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "IBR", oktitle:"Done", OkButtonBlock:{ (action)
            in
        })
        self.present(alert,animated: false,completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MobileVerificationOTPScene
        destinationVC.mobileNumber = mobileNumberTextField.text!
    }
    
}
