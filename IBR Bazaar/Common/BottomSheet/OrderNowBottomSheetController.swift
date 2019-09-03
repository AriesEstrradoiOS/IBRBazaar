//
//  OrderNowBottomSheetController.swift
//  IBR Bazaar
//
//  Created by Monish M S on 16/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class OrderNowBottomSheetController:UIViewController{
    
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var addImageView: UIImageView!
    @IBOutlet var subtractImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var productNumber: UILabel!
    
    var priceValue:Int = 0
    var priceItemsValue:Int = 0
    var productNumberValue:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.cornerRadius = 5
        addToCartButton.layer.cornerRadius = 5
    }
}
