//
//  RestaurantDetailsByFilterResponse.swift
//  ShawManApp
//
//  Created by Jai Mataji on 24/02/21.
//

import Foundation

struct RestaurantDetailsByFilterResponse :Codable {
    var AllRestaurantDishes : [AllRestaurantDishes]!
    var NoOfRestaurants : NoOfRestaurants!
    var Message : String!
    
    enum CodingKeys : String, CodingKey {
        case AllRestaurantDishes = "AllRestaurantDishes"
        case NoOfRestaurants = "NoOfRestaurants"
        case Message = "Message"
    }
}

struct NoOfRestaurants : Codable {
    var NoOfRestaurants : Int!
    
    enum CodingKeys : String, CodingKey {
        case NoOfRestaurants = "NoOfRestaurants"
    }
}

struct AllRestaurantDishes :Codable {
    var RestaurantId : Int!
    var RestaurantName : String!
    var RestaurantDishId : Int!
    var RestaurantDishName : String!
    var LocationName : String!
    var RestaurantCity : String!
    var Distance : Double!
    var Votes : Int!
    var DishRank : Int!
    var Latitude : String!
    var Longitude : String!
    var DishImage : String!
    var PromoFlag : Int!
    var FmUsers : Int!
    var NoOfCoupons : Int!
    var TotalPledge : Int!
    var DishType : Int!
    var Friends : Int!
    var DishSequence : Int!
    var Cuisines : String!
    var AccountId : Int!
    var ChainOfRest : Int
    
    enum CodingKeys: String, CodingKey {
        case RestaurantId = "RestaurantId"
        case RestaurantName = "RestaurantName"
        case RestaurantDishId = "RestaurantDishId"
        case RestaurantDishName = "RestaurantDishName"
        case LocationName = "LocationName"
        case RestaurantCity = "RestaurantCity"
        case Distance = "Distance"
        case Votes = "Votes"
        case DishRank = "DishRank"
        case Latitude = "Latitude"
        case Longitude = "Longitude"
        case DishImage = "DishImage"
        case PromoFlag = "PromoFlag"
        case FmUsers = "FmUsers"
        case NoOfCoupons = "NoOfCoupons"
        case TotalPledge = "TotalPledge"
        case DishType = "DishType"
        case Friends = "Friends"
        case DishSequence = "DishSequence"
        case Cuisines = "Cuisines"
        case AccountId = "AccountId"
        case ChainOfRest = "ChainOfRest"
    }
}


