//
//  StoresTableViewCell.swift
//  IBR Bazaar
//
//  Created by Monish M S on 13/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import Cosmos
class StoresTableViewCell:UITableViewCell{
    
    @IBOutlet var moreStoresLabelHeight: NSLayoutConstraint!
    @IBOutlet var storesImageView: UIImageView!
    @IBOutlet var storeName: UILabel!
    @IBOutlet var storeDistance: UILabel!
    @IBOutlet var ratingView: CosmosView!
}
