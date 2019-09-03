//
//  ShopsWithinDistanceVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 21/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

protocol distancePopOverProtocol:class {
    func distancePopOverDismissed()
}

import Foundation
import UIKit
class ShopsWithinDistanceVC:UIViewController{
    
    @IBOutlet var distancePickerView: UIPickerView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var applyButton: UIButton!
    @IBOutlet var mainView: UIView!
    
    var data = ["0","5","10","15","20"]
    let pickerDataSize = 10000
    weak var delegate : distancePopOverProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPicker()
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
        cancelButton.layer.cornerRadius = 5
        applyButton.layer.cornerRadius = 5
        mainView.layer.cornerRadius = 5
    }
    
    func setupPicker(){
        distancePickerView.delegate = self
        distancePickerView.dataSource = self
        distancePickerView.selectRow(data.count-1, inComponent: 0, animated: false)
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        delegate?.distancePopOverDismissed()
        self.view.removeFromSuperview()
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        delegate?.distancePopOverDismissed()
        self.view.removeFromSuperview()
    }
}
extension ShopsWithinDistanceVC:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSize
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ca = row%data.count
        return data[ca]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myRow = row%data.count
        print("data value is==\(data[myRow])")
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
