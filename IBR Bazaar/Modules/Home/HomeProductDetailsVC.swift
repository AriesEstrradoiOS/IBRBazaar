//
//  HomeProductDetailsVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 16/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class HomeProductDetailsVC:UIViewController{
    
    @IBOutlet var orderNowButton: UIButton!
    @IBOutlet var scheduleButton: UIButton!
    @IBOutlet var productView: UIView!
    @IBOutlet var header: CommonHeaderDeliveryAddress!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var likeIcon: UIImageView!
    
    let yellowColor = UIColor(red: 239.0/255.0, green: 189.0/255.0, blue: 9.0/255.0, alpha: 1.0)
    var orderNowBottomSheetVC = OrderNowBottomSheetController()
    var scheduleBottomSheetVC = ScheduleBottomSheetViewController()
    var timeSlotValuesList = ["05:00 PM - 07:00 PM","06:00 PM - 08:00 PM","07:00 PM - 09:00 PM","08:00 PM - 10:00 PM"]
    var timeSlotDatePicker = UIDatePicker()
    var timeSlotStackViewHeight:CGFloat = 0.0
    var timeslotButtonList = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addFloatingButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        orderNowButton.layer.cornerRadius = 5
        scheduleButton.layer.cornerRadius = 5
        let backgesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        let likegesture = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        header.backButton.isUserInteractionEnabled = true
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deliveryAddressButtonTapped))
        header.deliveryAddress.isUserInteractionEnabled = true
        header.deliveryAddress.addGestureRecognizer(tapGesture)
        likeIcon.isUserInteractionEnabled = true
        header.backButton.addGestureRecognizer(backgesture)
        likeIcon.tag = 0
        likeIcon.image = UIImage(named: "unlike")
        likeIcon.addGestureRecognizer(likegesture)
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        productView.dropNarrowShadow(view: productView)
        orderNowButton.dropNarrowShadow(view: orderNowButton)
        scheduleButton.dropNarrowShadow(view: scheduleButton)
    }
    
    func addFloatingButton(){
        let view = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY-10, width: 50, height: 50))
        view.backgroundColor = yellowColor
        let button = UIImageView(frame: CGRect(x: 0, y: self.view.frame.maxY-20, width: 25, height: 25))
        view.addSubview(button)
        self.view.addSubview(view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        view.widthAnchor.constraint(equalToConstant:50).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5.0
        
        button.image = UIImage(named: "cart")
        button.widthAnchor.constraint(equalToConstant:25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let cartViewGesture = UITapGestureRecognizer(target: self, action: #selector(cartViewButtonTapped))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(cartViewGesture)
    }
    
    func addOrderNowBottomSheetView() {
        self.addChild(orderNowBottomSheetVC)
        orderNowBottomSheetVC.view.inputAccessoryView?.backgroundColor = UIColor.clear
        orderNowBottomSheetVC.cancelButton.addTarget(self, action: #selector(orderNowBackButtonTapped), for: .touchUpInside)
        orderNowBottomSheetVC.addToCartButton.addTarget(self, action: #selector(cartViewButtonTapped), for: .touchUpInside)
        let addGestue = UITapGestureRecognizer(target: self, action: #selector(orderNowAddButtonTapped))
        orderNowBottomSheetVC.addImageView.isUserInteractionEnabled = true
        orderNowBottomSheetVC.addImageView.addGestureRecognizer(addGestue)
        let subtractGesture = UITapGestureRecognizer(target: self, action: #selector(OrderNowSubtractButtonTapped))
        orderNowBottomSheetVC.subtractImageView.isUserInteractionEnabled = true
        orderNowBottomSheetVC.subtractImageView.addGestureRecognizer(subtractGesture)
        self.view.addSubview(orderNowBottomSheetVC.view)
        orderNowBottomSheetVC.didMove(toParent: self)
        let height = self.view.frame.height
        let width  = self.view.frame.width
        orderNowBottomSheetVC.view.frame = CGRect(x: 0, y: 1 , width: width, height: height)
        orderNowBottomSheetVC.priceValue = 60
        orderNowBottomSheetVC.priceItemsValue = 60
        orderNowBottomSheetVC.productNumberValue = 1
        orderNowBottomSheetVC.priceLabel.text = "Price: ₹"+String(orderNowBottomSheetVC.priceValue)
    }
    
    func addScheduleBottomSheetView(){
        self.addChild(scheduleBottomSheetVC)
        scheduleBottomSheetVC.view.inputAccessoryView?.backgroundColor = UIColor.clear
        scheduleBottomSheetVC.cancelButton.addTarget(self, action: #selector(scheduleBackButtonTapped), for: .touchUpInside)
        scheduleBottomSheetVC.addToCartButton.addTarget(self, action: #selector(cartViewButtonTapped), for: .touchUpInside)
        let addGestue = UITapGestureRecognizer(target: self, action: #selector(scheduleAddButtonTapped))
        scheduleBottomSheetVC.addButton.isUserInteractionEnabled = true
        scheduleBottomSheetVC.addButton.addGestureRecognizer(addGestue)
        let subtractGesture = UITapGestureRecognizer(target: self, action: #selector(scheduleSubtractButtonTapped))
        scheduleBottomSheetVC.subtractButton.isUserInteractionEnabled = true
        scheduleBottomSheetVC.subtractButton.addGestureRecognizer(subtractGesture)
        let imageview = UIImageView(image: UIImage(named: "date"))
        imageview.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        scheduleBottomSheetVC.dateTextField.rightView = imageview
        scheduleBottomSheetVC.dateTextField.rightViewMode = .always
        scheduleBottomSheetVC.dateTextField.delegate = self
        scheduleBottomSheetVC.dateTextField.addTarget(self, action: #selector(dateChanged(_:)), for: .touchDown)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let result = formatter.string(from: date)
        timeSlotDatePicker.date = Date()
        scheduleBottomSheetVC.dateTextField.text = result
        timeSlotDatePicker.datePickerMode = .date
        scheduleBottomSheetVC.dateTextField.inputView = timeSlotDatePicker
        timeSlotDatePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        scheduleBottomSheetVC.dateButton.layer.cornerRadius = 3
        
        self.view.addSubview(scheduleBottomSheetVC.view)
        scheduleBottomSheetVC.didMove(toParent: self)
        let height = self.view.frame.height
        let width  = self.view.frame.width
        scheduleBottomSheetVC.view.frame = CGRect(x: 0, y: 1 , width: width, height: height)
        scheduleBottomSheetVC.priceValue = 60
        scheduleBottomSheetVC.priceItemsValue = 60
        scheduleBottomSheetVC.productNumberValue = 1
        scheduleBottomSheetVC.priceLabel.text = "Price: ₹"+String(scheduleBottomSheetVC.priceValue)
        
        //scheduleBottomSheetVC.timeslotStackViewHeight.constant = 0
       // scheduleBottomSheetVC.timeSlotStackView.isHidden = true
       // scheduleBottomSheetVC.viewHeight.constant = 200
        createSheduledTimeSlots()
        
    }
    
    func createSheduledTimeSlots(){
        let hor_stck_val = 4
        let topPos = hor_stck_val/3
        var subPos = 3
        var count:Int = 0
        for i in 0...topPos{
            
            let hor_time_SV = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            hor_time_SV.translatesAutoresizingMaskIntoConstraints = false
            hor_time_SV.axis = .horizontal
            hor_time_SV.spacing = 5.0
            hor_time_SV.alignment = .fill
            hor_time_SV.distribution = .fillEqually
            hor_time_SV.isUserInteractionEnabled = true
            if i == topPos{
                subPos = hor_stck_val%3
            }
            for j in 1...3{
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                if i == topPos{
                    if subPos != 0{
                        if j<=subPos{
                            print("subPos=\(subPos) and j = \(j)")
                            button.setTitle(timeSlotValuesList[j], for: .normal)
                            button.backgroundColor = UIColor.lightGray
                            button.setTitleColor(UIColor.black, for: .normal)
                            button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
                            button.layer.cornerRadius = 3
                            button.isUserInteractionEnabled = true
                            button.tag = count
                            button.addTarget(self, action: #selector(self.timeslotButtonTapped(_:)), for: .touchUpInside)
                            timeslotButtonList.append(button)
                        }else{
                            print(" j = \(j)")
                            button.setTitle("", for: .normal)
                            button.backgroundColor = UIColor.white
                            button.isUserInteractionEnabled = false
                        }
                    }
                }else{
                    button.setTitle(timeSlotValuesList[j], for: .normal)
                    button.backgroundColor = UIColor.lightGray
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
                    button.layer.cornerRadius = 3
                    button.isUserInteractionEnabled = true
                    button.tag = count
                    button.addTarget(self, action: #selector(self.timeslotButtonTapped(_:)), for: .touchUpInside)
                    timeslotButtonList.append(button)
                }
                if subPos != 0{
                    hor_time_SV.addArrangedSubview(button)
                }
                count = count + 1
            }
            scheduleBottomSheetVC.timeSlotStackView.addArrangedSubview(hor_time_SV)
        }
        print("count = \(count)")

            let val = hor_stck_val%3
            if val == 0{
               timeSlotStackViewHeight = CGFloat((topPos)*30)
            }else{
                
                timeSlotStackViewHeight = CGFloat((topPos+1)*30)
            }
        scheduleBottomSheetVC.timeslotStackViewHeight.constant = timeSlotStackViewHeight
        scheduleBottomSheetVC.timeSlotStackView.isHidden = false
        scheduleBottomSheetVC.viewHeight.constant = 200+scheduleBottomSheetVC.timeslotStackViewHeight.constant
        
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func orderNowBackButtonTapped(){
      orderNowBottomSheetVC.view.removeFromSuperview()
    }
    
    @objc func scheduleBackButtonTapped(){
        scheduleBottomSheetVC.view.removeFromSuperview()
    }
    
    @objc func likeButtonTapped(){
        if likeIcon.tag == 0{
            likeIcon.tag = 1
            likeIcon.image = UIImage(named: "like")
        }else{
            likeIcon.tag = 0
            likeIcon.image = UIImage(named: "unlike")
        }
    }
    
    @objc func cartViewButtonTapped(){
        self.view.removeFromSuperview()
        self.tabBarController?.selectedIndex = 1
    }
    
    
    @objc func orderNowAddToCartButtonTapped(){
        
    }
    
    @objc func scheduleAddToCartButtonTapped(){
        
    }
    
    @objc func orderNowAddButtonTapped(){
        orderNowBottomSheetVC.priceItemsValue = orderNowBottomSheetVC.priceItemsValue+orderNowBottomSheetVC.priceValue
        orderNowBottomSheetVC.priceLabel.text = "Price: ₹"+String(orderNowBottomSheetVC.priceItemsValue)
        orderNowBottomSheetVC.productNumberValue = orderNowBottomSheetVC.productNumberValue + 1
        orderNowBottomSheetVC.productNumber.text = String(orderNowBottomSheetVC.productNumberValue)
    }
    
    @objc func OrderNowSubtractButtonTapped(){
        let val =  orderNowBottomSheetVC.productNumberValue - 1
        if val != 0{
            orderNowBottomSheetVC.priceItemsValue = orderNowBottomSheetVC.priceItemsValue-orderNowBottomSheetVC.priceValue
            orderNowBottomSheetVC.priceLabel.text = "Price: ₹"+String(orderNowBottomSheetVC.priceItemsValue)
            orderNowBottomSheetVC.productNumberValue = val
            orderNowBottomSheetVC.productNumber.text = String(orderNowBottomSheetVC.productNumberValue)
        }
    }
    
    @objc func scheduleAddButtonTapped(){
        scheduleBottomSheetVC.priceItemsValue = scheduleBottomSheetVC.priceItemsValue+scheduleBottomSheetVC.priceValue
        scheduleBottomSheetVC.priceLabel.text = "Price: ₹"+String(scheduleBottomSheetVC.priceItemsValue)
        scheduleBottomSheetVC.productNumberValue = scheduleBottomSheetVC.productNumberValue + 1
        scheduleBottomSheetVC.productNumber.text = String(scheduleBottomSheetVC.productNumberValue)
    }
    
    @objc func scheduleSubtractButtonTapped(){
        let val =  scheduleBottomSheetVC.productNumberValue - 1
        if val != 0{
            scheduleBottomSheetVC.priceItemsValue = scheduleBottomSheetVC.priceItemsValue-scheduleBottomSheetVC.priceValue
            scheduleBottomSheetVC.priceLabel.text = "Price: ₹"+String(scheduleBottomSheetVC.priceItemsValue)
            scheduleBottomSheetVC.productNumberValue = val
            scheduleBottomSheetVC.productNumber.text = String(scheduleBottomSheetVC.productNumberValue)
        }
    }
    
    @objc func dateChanged(_ textField:UITextField){
        print("dateChanged")
        
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        scheduleBottomSheetVC.dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func timeslotButtonTapped(_ button:UIButton) {
        print("tapped\(button.tag)")
        for i in 0 ..< timeslotButtonList.count{
            if i == button.tag{
                timeslotButtonList[i].backgroundColor = yellowColor
            }else{
                timeslotButtonList[i].backgroundColor = UIColor.lightGray
            }
        }
        
    }
    
    @objc func deliveryAddressButtonTapped(){
        self.performSegue(withIdentifier: "segueDetailsVCToDeliverySegue", sender: nil)
    }
    
    
    @IBAction func orderNowButtonClicked(_ sender: Any) {
        addOrderNowBottomSheetView()
    }
    
    
    @IBAction func sheduleButtonTapped(_ sender: Any) {
       addScheduleBottomSheetView()
    }
    
}

extension HomeProductDetailsVC:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == scheduleBottomSheetVC.dateTextField{
            scheduleBottomSheetVC.timeslotStackViewHeight.constant = timeSlotStackViewHeight
            if scheduleBottomSheetVC.timeslotStackViewHeight.constant != 0{
                scheduleBottomSheetVC.timeSlotStackView.isHidden = false
                scheduleBottomSheetVC.viewHeight.constant = 200+scheduleBottomSheetVC.timeslotStackViewHeight.constant
            }
        }
    }
}
