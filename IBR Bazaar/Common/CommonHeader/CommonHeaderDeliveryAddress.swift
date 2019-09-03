//
//  CommonHeaderDeliveryAddress.swift
//  IBR Bazaar
//
//  Created by Monish M S on 06/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class CommonHeaderDeliveryAddress:UIView{
    
    @IBOutlet var deliveryAddress: UILabel!
    @IBOutlet var backButton: UIImageView!
    @IBOutlet var deliveryAddressLabel: UILabel!
    @IBOutlet var editButton: UIImageView!
    @IBOutlet var deliveryAddressLabelHeight: NSLayoutConstraint!
    
    var view:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CommonHeaderDeliveryAddress", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    private func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
}
