//
//  ViewController.swift
//  ShawManApp
//
//  Created by Jai Mataji on 24/02/21.
//

import UIKit
import Alamofire

class ViewController: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        getFormatedAddress()
        getRestaurantDetailsByFilter()
        getSingleRestaurantDetails()
        // Do any additional setup after loading the view.
    }


    // MARK: API Call
    func getFormatedAddress(){
        self.showProgressIndicator()
        let parameters: [String:String] = [
            "StrLocLatitude":"19.1105765",
            "StrLocLongitude":"73.0174654"
        ]
        APIMananger.getFormatedAddress(parameters: parameters).responseDecodable(of: FormatedAddressResponse.self) { response in
            self.hideProgressIndicator()
            if let data = response.value{

            }else{
                self.showAlert(title: "Error", message: "Something went wrong, please try later")
            }
        }
    }
    
    func getRestaurantDetailsByFilter(){
        self.showProgressIndicator()
        let parameters: [String:String] = [
            "StrLocLatitude":"19.1105765",
            "StrLocLongitude":"73.0174654",
            "StrLocCityName":"19.1105765",
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
            "StrLocLatitude":"19.114644",
            "StrLocLongitude":"73.0229018",
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

