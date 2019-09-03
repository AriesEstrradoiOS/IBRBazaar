//
//  SliderBaseViewTableViewCell.swift
//  IBR Bazaar
//
//  Created by Monish M S on 19/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class SliderBaseViewTableViewCell:UITableViewCell{
    
    @IBOutlet var baseView: SliderBaseView!
   // var baseView = SliderBaseView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakefromnib.....")
        //addSubview(baseView)
    }
}
