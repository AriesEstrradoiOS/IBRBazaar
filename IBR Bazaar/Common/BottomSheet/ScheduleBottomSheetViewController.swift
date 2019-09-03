//
//  ScheduleBottomSheetViewController.swift
//  IBR Bazaar
//
//  Created by Monish M S on 18/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class ScheduleBottomSheetViewController:UIViewController{
    
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var timeSlotStackView: UIStackView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var addButton: UIImageView!
    @IBOutlet var subtractButton: UIImageView!
    @IBOutlet var productNumber: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var viewHeight: NSLayoutConstraint!
    @IBOutlet var timeslotStackViewHeight: NSLayoutConstraint!
    @IBOutlet var dateButton: UIButton!
    
    
    var priceValue:Int = 0
    var priceItemsValue:Int = 0
    var productNumberValue:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.cornerRadius = 5
        addToCartButton.layer.cornerRadius = 5
    }
}
