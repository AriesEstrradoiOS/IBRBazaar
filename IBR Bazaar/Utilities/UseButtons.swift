//
//  UseButtons.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/06/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit

class UseButtons: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createCorner()
    }
    func createCorner(){
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}

extension UIButton{
    func dropNarrowShadow(view:UIButton){
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowRadius = 1
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.masksToBounds = false
    }
}
