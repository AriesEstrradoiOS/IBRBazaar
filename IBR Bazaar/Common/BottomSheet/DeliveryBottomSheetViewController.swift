//
//  BottomSheetViewController.swift
//  IBR Bazaar
//
//  Created by Monish M S on 06/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class DeliveryBottomSheetViewController:UIViewController{
    
    @IBOutlet var deliveryButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var subView: UIView!
    
    let fullView: CGFloat = 0
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - ( UIApplication.shared.statusBarFrame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.cornerRadius = 5
        deliveryButton.layer.cornerRadius = 5
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            let frame = self?.view.frame
            self!.subView.frame = CGRect(x: 0, y: (self!.view.frame.origin.y), width: frame!.width, height: frame!.height)
        })
    }
    
}
