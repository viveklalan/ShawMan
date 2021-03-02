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
    var lastFetchCount = 0
    var isFetchingData = false
    
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let TotalPage = self.restaurantDetailData.NoOfRestaurants.NoOfRestaurants ?? 0
        let lastItem = self.restaurantList.count - 1
        if indexPath.row == lastItem {
            if self.lastFetchCount < TotalPage {
                !isFetchingData ? self.getRestaurantDetailsByFilter() : nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantDetailVC") as! RestaurantDetailVC
         vc.restaurantData = restaurantList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
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
        isFetchingData = true
        let parameters: [String:String] = [
            "StrLocLatitude": currentLatLong.latitude,
            "StrLocLongitude": currentLatLong.longitude,
            "StrLocCityName": self.locationData.CityName,
            "IntLocOrderby": "1",
            "IntLocNoOfRecords": "\(self.lastFetchCount)"
        ]
        APIMananger.getRestaurantDetailsByFilter(parameters: parameters).responseDecodable(of: RestaurantDetailsByFilterResponse.self) { response in
            self.hideProgressIndicator()
            self.isFetchingData = false
            if let data = response.value{
                if let restList = data.AllRestaurantDishes{
                    self.restaurantDetailData = data
                    self.restaurantList.append(contentsOf: restList)
                    self.lastFetchCount = self.restaurantList.count
                    self.restaurantTableView.reloadData()
                }
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

func getKmValue(meter:Double)->String{
    return String(format: "%.2f Km", (meter / 1000))
}
