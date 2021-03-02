//
//  RestaurantListVC.swift
//  ShawManApp
//
//  Created by Jai Mataji on 24/02/21.
//

import UIKit
import Alamofire
import CoreLocation

class RestaurantListVC: BaseVC{
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    var locationManager: CLLocationManager!
    var locationData: FormatedAddressResponse!
    var restaurantDetailData: RestaurantDetailsByFilterResponse!
    var restaurantList = [AllRestaurantDishes]()
    
    var currentLatLong = (latitude: "", longitude: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestLocation()
        }
    }
    
    
    
    
    
}

// MARK: TableView datasource/ delegate
extension RestaurantListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    //RestaurantName
    //Votes
    //Cuisines
    //
    //RestaurantCity , LocationName | Distance
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = restaurantList[indexPath.row]
        let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! restroCell
        cell.restName.text = data.RestaurantName ?? ""
        cell.restCuisines.text = data.Cuisines ?? ""
        cell.restRating.text = "\(data.Votes ?? 0)"
        cell.restLocationDistance.text = "\(data.RestaurantCity ?? ""), \(data.LocationName ?? "") | \(getKmValue(meter: data.Distance))"
        cell.restImageView.image = UIImage(named: ["rest1","rest2","rest3","rest4","rest5"].randomElement()!)
        
        
        cell.contentMainView.addBorderWithRadiusAndShadow()
        
        return cell
    }
    
    
    
    //Utility
    func getKmValue(meter:Double)->String{
        return String(format: "%.2f Km", (meter / 1000))
    }
    
}


// MARK: Corelocation delegate
extension RestaurantListVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("latitude = \(location.coordinate.latitude)")
            print("longitude = \(location.coordinate.longitude)")
            currentLatLong = ("\(location.coordinate.latitude)", "\(location.coordinate.longitude)")
//            currentLatLong = ("19.1105765", "73.0174654")
            getFormatedAddress()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

// MARK: API Call
extension RestaurantListVC{
    func getFormatedAddress(){
        self.showProgressIndicator()
        let parameters: [String:String] = [
            "StrLocLatitude":currentLatLong.latitude,
            "StrLocLongitude":currentLatLong.longitude
        ]
        APIMananger.getFormatedAddress(parameters: parameters).responseDecodable(of: FormatedAddressResponse.self) { response in
            self.hideProgressIndicator()
            if let data = response.value{
                self.locationData = data
                self.getRestaurantDetailsByFilter()
                if let message = data.Message{
                    self.showAlert(title: "Error", message: message)
                }
            }else{
                self.showAlert(title: "Error", message: "Something went wrong, please try later")
            }
        }
    }
    
    func getRestaurantDetailsByFilter(){
        self.showProgressIndicator()
        let parameters: [String:String] = [
            "StrLocLatitude":currentLatLong.latitude,
            "StrLocLongitude":currentLatLong.longitude,
            "StrLocCityName":self.locationData.CityName,
            "IntLocOrderby":"1",
            "IntLocNoOfRecords":"0"
        ]
        APIMananger.getRestaurantDetailsByFilter(parameters: parameters).responseDecodable(of: RestaurantDetailsByFilterResponse.self) { response in
            self.hideProgressIndicator()
            if let data = response.value{
                self.restaurantDetailData = data
                self.restaurantList = data.AllRestaurantDishes
                self.restaurantTableView.reloadData()
            }else{
                self.showAlert(title: "Error", message: "Something went wrong, please try later")
            }
        }
    }
    
    func getSingleRestaurantDetails(){
        self.showProgressIndicator()
        let parameters: [String:String] = [
            "StrLocLatitude":currentLatLong.latitude,
            "StrLocLongitude":currentLatLong.longitude,
            "IntLocRestaurantId":"639161"
        ]
        APIMananger.getSingleRestaurantDetails(parameters: parameters).responseDecodable(of: SingleRestaurantDetailResponse.self) { response in
            self.hideProgressIndicator()
            if let data = response.value{
                
            }else{
                self.showAlert(title: "Error", message: "Something went wrong, please try later")
            }
        }
    }
}


class restroCell: UITableViewCell {
    @IBOutlet weak var contentMainView: UIView!
    @IBOutlet weak var restImageView: UIImageView!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restCuisines: UILabel!
    @IBOutlet weak var restRating: UILabel!
    @IBOutlet weak var restLocationDistance: UILabel!
}
