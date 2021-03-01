//
//  ViewController.swift
//  ShawManApp
//
//  Created by Jai Mataji on 24/02/21.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: BaseVC, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var locationData: FormatedAddressResponse!
    
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
    
    
    // MARK: API Call
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

