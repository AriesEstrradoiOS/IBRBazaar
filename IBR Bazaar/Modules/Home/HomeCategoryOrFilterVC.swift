//
//  HomeCategoryOrFilterVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 22/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

protocol categorySelectedItemProtocol:class{
    func selectedItem(row:Int)
}

import Foundation
import UIKit
import UIKit.UIGestureRecognizer

class HomeCategoryOrFilterVC:UIViewController{
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainViewHeight: NSLayoutConstraint!
    @IBOutlet var categoryOrFilterListingTable: UITableView!
    @IBOutlet var headerViewLabel: UILabel!
    
    var categoriesList = ["Sweet Items","biscuit","Buiscut and cookie","Items"]
    var filterList = ["Wonder Cookies","All"]
    var isFilterVC:Bool = false
    weak var delegate: categorySelectedItemProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTable()
    }
    
    func setupUI(){
        if isFilterVC{
            headerViewLabel.text = "Filter by brand"
        }else{
            headerViewLabel.text = "Categories"
        }
    }
    
    func setupTable(){
        mainViewHeight.constant = 30
        let screenHeight = UIScreen.main.bounds.height - (UIApplication.shared.statusBarView?.bounds.height)!
        if isFilterVC{
            for _ in 0 ..< filterList.count{
                if mainViewHeight.constant > screenHeight-60{
                    break
                }else{
                    mainViewHeight.constant = mainViewHeight.constant + 30
                }
            }
        }else{
            for _ in 0 ..< categoriesList.count{
                if mainViewHeight.constant > screenHeight-60{
                    break
                }else{
                    mainViewHeight.constant = mainViewHeight.constant + 30
                }
            }
        }
        categoryOrFilterListingTable.delegate = self
        categoryOrFilterListingTable.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != mainView {
            self.view.removeFromSuperview()
        }
    }
}
extension HomeCategoryOrFilterVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterVC{
            return filterList.count
        }
        return categoriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCategoryOrFilterTableViewCell", for: indexPath) as! HomeCategoryOrFilterTableViewCell
        if isFilterVC{
           cell.textLabel?.text = filterList[indexPath.row]
        }else{
           cell.textLabel?.text = categoriesList[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.removeFromSuperview()
        if !isFilterVC{
            delegate?.selectedItem(row: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
}
