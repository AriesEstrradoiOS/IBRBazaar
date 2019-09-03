//
//  HomeLocationVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 06/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class HomeLocationVC:UIViewController,locationSearchEnableProtocol,UISearchControllerDelegate{
    
    @IBOutlet var header: CommonHeaderDeliveryAddress!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var headerHeight: NSLayoutConstraint!
    
    var locationManager = CLLocationManager()
    var setRegion:Bool = false
    var geocoder = CLGeocoder()
    let activityIndicatorView = UIActivityIndicatorView()
    let bottomSheetView = MapViewBottomSheetController()
    var resultSearchController:UISearchController? = nil
    var locationSearchTable = LocationSearchTable()
    var selectedPin:MKPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload...")
        self.navigationController?.navigationBar.isHidden = false
        headerHeight.constant = 0
        setupLocationSearchTableView()
        setupLocation()
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewdidappear...")
        if !self.children.contains(self.bottomSheetView) {
            print("inside")
            self.addBottomSheetView()
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewdiddisappear")
        self.mapView.delegate = nil
    }
    
    func setupUI(){
        header.backgroundColor = UIColor.clear
        header.deliveryAddress.text = userDefaults.GET_USERDEFAULTS(objectValue: "deliveryAddress")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        header.backButton.isUserInteractionEnabled = true
        header.backButton.addGestureRecognizer(gesture)
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
    }
    
    func setupLocationSearchTableView(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        locationSearchTable = storyBoard.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    func addBottomSheetView() {
        print("add bottom sheet view")
        bottomSheetView.partialView = CGFloat(mapView.bounds.maxY+CGFloat(50)+UIApplication.shared.statusBarFrame.height)
        bottomSheetView.delegate = self
        self.addChild(bottomSheetView)
        self.view.addSubview(bottomSheetView.view)
        bottomSheetView.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetView.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
    }
    
    func setupSearchBar(){
        navigationController?.navigationBar.isHidden = false
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController!.delegate = self
        resultSearchController!.searchResultsUpdater = locationSearchTable
        resultSearchController!.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        resultSearchController!.loadViewIfNeeded()
        
        resultSearchController!.searchBar.delegate = locationSearchTable
        resultSearchController!.hidesNavigationBarDuringPresentation = false
        resultSearchController!.searchBar.placeholder = "Search for places"
        resultSearchController!.searchBar.barTintColor = navigationController?.navigationBar.tintColor
        resultSearchController!.searchBar.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.titleView = resultSearchController!.searchBar
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: false)
        
    }
    
    func locationSearchActive(){
        print("location active")
        setupSearchBar()
        headerHeight.constant = 0
    }
}

extension HomeLocationVC:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
//            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//            if !setRegion{
//                 mapView.setRegion(region, animated: true)
//                 setRegion = true
//            }
            
            
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
            if !setRegion{
                mapView.setRegion(mapView.regionThatFits(region), animated: true)
                setRegion = true
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        
        activityIndicatorView.stopAnimating()
        
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                print("valuuueee ====\(placemark.compactAddress!)")
                
                bottomSheetView.compactAddress = placemark.compactAddress ?? ""
                bottomSheetView.name = placemark.name ?? ""
                bottomSheetView.locality = placemark.locality ?? ""
                bottomSheetView.administrativeArea = placemark.administrativeArea ?? ""
                bottomSheetView.thoroughfare = placemark.thoroughfare ?? ""
                bottomSheetView.postalCode = placemark.postalCode ?? ""
                if bottomSheetView.tableView != nil{
                  for i in 0 ..< bottomSheetView.locationList.count{
                    if i == 0{
                        bottomSheetView.locationList[i] =  placemark.name ?? ""
                    }else if i == 1{
                        bottomSheetView.locationList[i] =  placemark.thoroughfare ?? ""
                    }else if i == 2{
                        bottomSheetView.locationList[i] =  ""
                    }else if i == 3{
                        bottomSheetView.locationList[i] =  placemark.locality ?? ""
                    }else if i == 4{
                        bottomSheetView.locationList[i] =  placemark.administrativeArea ?? ""
                    }else if i == 5{
                        bottomSheetView.locationList[i] =  ""
                    }else if i == 6{
                         bottomSheetView.locationList[i] =  placemark.postalCode ?? ""
                    }
                  }
                  bottomSheetView.tableView.reloadData()
                }
            } else {
               print("No Matching Addresses Found")
            }
        }
    }
}

extension HomeLocationVC:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancelled")
        self.navigationController?.navigationBar.isHidden = true
        self.headerHeight.constant = 50
        setupUI()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        locationSearchTable.searchBarSearchButtonTapped = false
        locationSearchTable.updateSearchResultsForSearchController(searchController: resultSearchController!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        locationSearchTable.searchBarSearchButtonTapped = true
        locationSearchTable.updateSearchResultsForSearchController(searchController: resultSearchController!)
    }
}

extension HomeLocationVC:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        locationManager.startUpdatingLocation()
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        geocoder.reverseGeocodeLocation(loc) { (placemarks, error) in
            // Process Response
            print("Process Response")
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
}

extension CLPlacemark {
    
    var compactAddress: String? {
            if let name = name {
            var result = name
            
           
            if let state = administrativeArea{
                result += ", \(state)"
            }
            if let city = locality{
                result += ", \(city)"
            }
            if let country = country{
                result += ", \(country)"
            }
            if let code = postalCode{
                result += ", \(code)"
            }
            
            return result
        }
        
        return nil
    }
    
}

extension HomeLocationVC: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
//        selectedPin = placemark
//        // clear existing pins
//        mapView.removeAnnotations(mapView.annotations)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = placemark.coordinate
//        annotation.title = placemark.name
//        if let city = placemark.locality,
//            let state = placemark.administrativeArea {
//            annotation.subtitle = "(city) (state)"
//        }
//        mapView.addAnnotation(annotation)
        
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
//        mapView.setRegion(region, animated: true)
        
        let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
            mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
        
    }
}

