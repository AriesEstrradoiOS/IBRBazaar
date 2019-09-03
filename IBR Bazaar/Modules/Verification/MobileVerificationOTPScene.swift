//
//  MobileVerificationOTPScene.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/06/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

class MobileVerificationOTPScene:UIViewController{
    
    @IBOutlet var middleView: UseViews!
    @IBOutlet var resendOTPLabel: UILabel!
    @IBOutlet var resendButton: UIButton!
    @IBOutlet var backButton: UIImageView!
    @IBOutlet var verifyAndProceedButton: UseButtons!
    @IBOutlet var verifyAndProceedButtonHeight: NSLayoutConstraint!
    @IBOutlet var mobileNumberTextField: SkyFloatingLabelTextField!
    
    var mobileNumber:String = ""
    
    var seconds = 50
    var timer = Timer()
    var isTimerRunning = false
    var resendButtonTapped:Bool = false
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        resendButton.isHidden = true
        runTimer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        middleView.dropShadow()
    }
    
    func setupUI(){
        mobileNumberTextField.delegate = self
        verifyAndProceedButtonHeight.constant = 0
        let backbuttonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backbuttonGestureRecognizer)
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
    }
    
    @objc func backButtonTapped(){
        self.dismiss(animated: false, completion: nil)
    }
    
    func runTimer() {
        resendButtonTapped = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
        if seconds == 0{
            timer.invalidate()
            resendButton.isHidden = false
            resendOTPLabel.text = "Resend OTP"
            seconds = 50
            resendButtonTapped = false
            resendButton.setTitleColor(UIColor.blue, for: .normal)
        }else{
            resendOTPLabel.text = "Resend OTP in \(seconds) seconds"
            resendButton.isHidden = true
        }
        
    }
    
    @IBAction func resendButtonTapped(_ sender: Any) {
        if !resendButtonTapped{
            resendButtonTapped = true
            runTimer()
        }
        
    }
    
    @IBAction func verifyButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "showSegueToRegistrationVC", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RegistrationVC
        destinationVC.mobileNumber = mobileNumber
    }
    
    
    
}

extension MobileVerificationOTPScene:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if  textField.text!.count == 3{
           self.performSegue(withIdentifier: "showSegueToRegistrationVC", sender: nil)
        }
        return true
    }
}
