//
//  LocationSearchTable.swift
//  IBR Bazaar
//
//  Created by Monish M S on 08/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class LocationSearchTable:UITableViewController{
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var detailTextLabel: UILabel!
    
    var resultSearchController:UISearchController? = nil
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var handleMapSearchDelegate:HandleMapSearch? = nil
    var searchBarSearchButtonTapped:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults")
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print("updateSearchResultsForSearchController")
        self.matchingItems.removeAll()
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            if self.searchBarSearchButtonTapped{
                let selectedItem = self.matchingItems[0].placemark
                self.handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
                self.dismiss(animated: true, completion: nil)
            }else{
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellforrowat")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        print("selected Item ====\(selectedItem.description)")
       // cell.textLabel?.text = parseAddress(selectedItem: selectedItem)
        cell.textLabel?.text = selectedItem.title!
        cell.detailTextLabel?.text = selectedItem.description
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did selectrow atindexpath")
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
}
extension LocationSearchTable : UISearchBarDelegate {
}
