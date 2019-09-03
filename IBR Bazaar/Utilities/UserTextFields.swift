//
//  UserTextFields.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/06/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit

class UserTextFields: UITextField {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createBottomLine()
    }
    func createBottomLine(){
        let bottomLine = CALayer()
        print(UIScreen.main.bounds.width)
        print(self.bounds.width)
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.layer.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.red.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
