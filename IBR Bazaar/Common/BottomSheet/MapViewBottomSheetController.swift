//
//  MapViewBottomSheetController.swift
//  IBR Bazaar
//
//  Created by Monish M S on 07/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit

protocol locationSearchEnableProtocol:class {
    func locationSearchActive()
}


class MapViewBottomSheetController:UIViewController{
    
    @IBOutlet var tableView: UITableView!
    
    
    var fullView: CGFloat = 100
    var partialView:CGFloat = 0
    var textFieldTitles = ["House Name / Door No*","Area / Locality / Street*","Landmark*","District*","State*","Post*","Pincode*"]
    var name:String = ""
    var compactAddress:String = ""
    var locality:String = ""
    var administrativeArea:String = ""
    var thoroughfare:String = ""
    var postalCode:String = ""
    var locationList = ["","","","","","",""]
    weak var delegate:locationSearchEnableProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fullView = 100
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isMovingToParent{
            print("Animation...")
//            UIView.animate(withDuration: 0.6, animations: { [weak self] in
//                let frame = self?.view.frame
//                let yComponent = self?.partialView
//                self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height - 100)
//            })
            let frame = self.view.frame
            let yComponent = self.partialView
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height - 100)
        }
    }
    
    func setupUI(){
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        self.tableView.layer.borderColor = UIColor.lightGray.cgColor
        self.tableView.layer.borderWidth = 1
    }
    
    func setupTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DeliverySearchTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliverySearchTableViewCell")
        tableView.register(UINib(nibName: "DeliveryCustomTextFieldCell", bundle: nil), forCellReuseIdentifier: "DeliveryCustomTextFieldCell")
        tableView.register(UINib(nibName: "DeliverySubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliverySubmitTableViewCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        print("first time..")
        tableView.reloadData()
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {

            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: { [weak self] _ in
                if ( velocity.y < 0 ) {
                    self?.tableView.isScrollEnabled = true
                }
            })
        }
    }
}

extension MapViewBottomSheetController: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        if (y == fullView && tableView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
        
        return false
    }
    
}

extension MapViewBottomSheetController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        print("sections called..")
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 7
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var searchCell = DeliverySearchTableViewCell()
        var textfieldsCell = DeliveryCustomTextFieldCell()
        var submitButtonCell = DeliverySubmitTableViewCell()
        if indexPath.section == 0{
            searchCell = tableView.dequeueReusableCell(withIdentifier: "DeliverySearchTableViewCell", for: indexPath) as! DeliverySearchTableViewCell
            searchCell.searhTextField.text = compactAddress
            searchCell.searhTextField.titleFormatter = { $0 }
            searchCell.searhTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .touchDown)
            return searchCell
        }else if indexPath.section == 1{
            textfieldsCell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCustomTextFieldCell", for: indexPath) as! DeliveryCustomTextFieldCell
            textfieldsCell.deliveryTextField.placeholder = textFieldTitles[indexPath.row]
            textfieldsCell.deliveryTextField.titleFormatter = { $0 }
            textfieldsCell.deliveryTextField.tag = indexPath.row
            textfieldsCell.deliveryTextField.delegate = self
            textfieldsCell.deliveryTextField.text = locationList[indexPath.row]
            return textfieldsCell
        }
        else{
            submitButtonCell = tableView.dequeueReusableCell(withIdentifier: "DeliverySubmitTableViewCell", for: indexPath) as! DeliverySubmitTableViewCell
            submitButtonCell.submitButton.layer.cornerRadius = 5
            submitButtonCell.submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
            return submitButtonCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    @objc func textFieldDidChange(_ textField:UITextField){
        delegate?.locationSearchActive()
    }
    
    @objc func submitButtonTapped(_ button:UIButton){
        if tableView != nil{
            var flag:Bool = false
            for i in 0 ..< locationList.count{
                if locationList[i] == ""{
                    flag = true
                    break
                }
            }
            
            if flag{
               showPopUp(message: "Please fill mandatory fields")
            }else{
                userDefaults.SET_USERDEFAULTS(user_language: locationList[0], objectValue: "deliveryAddress")
                self.navigationController?.popViewController(animated: false)
            }
        }
    }
    
    func showPopUp(message:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "IBR", oktitle:"Done", OkButtonBlock:{ (action)
            in
        })
        self.present(alert,animated: false,completion: nil)
    }
}

extension MapViewBottomSheetController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textfield tag===\(textField.tag)")
        locationList[textField.tag] = textField.text!
    }
}
