//
//  UseViews.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/06/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit

class UseViews: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createBorder()
    }
    
    func createBorder(){
        let color = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
extension UIView {
    
    func dropShadow(scale: Bool = true) {
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.bounds.size.width + shadowSize,
                                                   height: self.bounds.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func dropNarrowShadow(view:UIView){
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowRadius = 1
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.masksToBounds = false
    }
}
extension UIView{
    func setUPBackGroundImage(mainView:UIView,image:UIImage){
        UIGraphicsBeginImageContext(mainView.frame.size)
        image.draw(in: mainView.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        mainView.backgroundColor = UIColor(patternImage: image)
    }
}
