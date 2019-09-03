//
//  HomeDeliveryAddressVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 06/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class HomeDeliveryAddressVC:UIViewController{
    
    @IBOutlet var header: CommonHeaderDeliveryAddress!
    @IBOutlet var deliveryTableView: UITableView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        let address = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        header.deliveryAddress.text = address
        if address != ""{
           setupTableView()
        }
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        header.backgroundColor = UIColor.clear
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        header.backButton.isUserInteractionEnabled = true
        header.backButton.addGestureRecognizer(gesture)
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        setupLocation()
    }
    
    func setupTableView(){
        deliveryTableView.delegate = self
        deliveryTableView.dataSource = self
        deliveryTableView.separatorStyle = .none
        deliveryTableView.register(UINib(nibName: "DeliveryAddressVCCell", bundle: nil), forCellReuseIdentifier: "DeliveryAddressVCCell")
        deliveryTableView.rowHeight = UITableView.automaticDimension
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func deleiveryAddressButtonTapped(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                openSettings()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                self.performSegue(withIdentifier: "segueToHomeLocationVC", sender: nil)
            @unknown default:
                print("error")
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    func openSettings(){
        let alertController = UIAlertController (title: "Location", message: "Please go to settings to enable the location service", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension HomeDeliveryAddressVC:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            openSettings()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: (location)")
        }
    }
}

extension HomeDeliveryAddressVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryAddressVCCell", for: indexPath) as! DeliveryAddressVCCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
