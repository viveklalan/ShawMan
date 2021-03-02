//
//  APIManager.swift
//  ShawManApp
//
//  Created by Jai Mataji on 24/02/21.
//

import Foundation
import Alamofire


var currentLatLong = (latitude: "", longitude: "")

struct URLS{
    public static let GET_ADDRESS = "https://fmtest.dishco.com/shawmanservices/api/GetFormatedAddress/FunPubRetrieveFormatedAddress"
    
    public static let GET_REST_FILTER = "https://fmtest.dishco.com/shawmanservices/api/RestaurantDetailsByFilter/GetFunPubRestaurantDetailsByFilter"
    
    public static let GET_REST_DETAILS = "https://fmtest.dishco.com/shawmanservices/api/SingleRestaurantDetails/GetFuncPubGetSingleRestaurantDetails"
    
}

public class APIMananger: NSObject {
    public static var session:Session?
    
    public static let headers:HTTPHeaders = ["AndroidPhone" : "EV6FTlgBhOalM+qjJpr2OZpAEpPkYJHC5I1aOWyeLevwSIpuzyKEAg=="]
    
    public static func getFormatedAddress(parameters: [String: String]) -> DataRequest{
        
        return AF.request(URLS.GET_ADDRESS,method:.get,parameters: parameters, headers: headers)
    }
    
    public static func getRestaurantDetailsByFilter(parameters: [String: String]) -> DataRequest{
        
        return AF.request(URLS.GET_REST_FILTER,method:.get,parameters: parameters, headers: headers)
    }
    
    public static func getSingleRestaurantDetails(parameters: [String: String]) -> DataRequest{
        
        return AF.request(URLS.GET_REST_DETAILS,method:.get,parameters: parameters, headers: headers)
    }
}
