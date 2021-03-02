//
//  SingleRestaurantDetailResponse.swift
//  ShawManApp
//
//  Created by Jai Mataji on 24/02/21.
//

import Foundation

struct SingleRestaurantDetailResponse :Codable {
    var RestaurantID: Int!
    var RestaurantName: String!
    var RestaurantAddress: String!
    var Location: String!
    var ContactNumber: String!
    var Votes: String!
    var Rating: Int!
    var OpeningsHours: String!
    var RestaurantLogo: String!
    var AvgMealRate: Int!
    var BOTRestaurantId: Int!
    var Distance: Double!
    var Latitude: String!
    var Longitude: String!
    var TotalPledge: Int!
    var PromoDetails: String!
    var PromoURL: String!
    var PromoImage: String!
    var RestaurantFlag: Int!
    var ShareFlag: Int!
    var FeedbackFacility: Int!
    var HomeDelivery: Int!
    var IsClubAccount: Int!
    var HappyHoursFromTime: String!
    var HappyHoursToTime: String!
    var MenuImages: [MenuImages]!
    var RestaurantDishes: [RestaurantDishes]!
    var Facilities: [Facilities]!
    var Cuisines: [Cuisines]!
    var CityId: Int!
    var CityName: String!
    var MinOrder: String!
    var MinTime: String!
    var RestaurantImage: String!
    var HomeDeliveryDistRange: Int!
    
    enum CodingKeys : String, CodingKey {
        case RestaurantID = "RestaurantID"
        case RestaurantName = "RestaurantName"
        case RestaurantAddress = "RestaurantAddress"
        case Location = "Location"
        case ContactNumber = "ContactNumber"
        case Votes = "Votes"
        case Rating = "Rating"
        case OpeningsHours = "OpeningsHours"
        case RestaurantLogo = "RestaurantLogo"
        case AvgMealRate = "AvgMealRate"
        case BOTRestaurantId = "BOTRestaurantId"
        case Distance = "Distance"
        case Latitude = "Latitude"
        case Longitude = "Longitude"
        case TotalPledge = "TotalPledge"
        case PromoDetails = "PromoDetails"
        case PromoURL = "PromoURL"
        case PromoImage = "PromoImage"
        case RestaurantFlag = "RestaurantFlag"
        case ShareFlag = "ShareFlag"
        case FeedbackFacility = "FeedbackFacility"
        case HomeDelivery = "HomeDelivery"
        case IsClubAccount = "IsClubAccount"
        case HappyHoursFromTime = "HappyHoursFromTime"
        case HappyHoursToTime = "HappyHoursToTime"
        case MenuImages = "MenuImages"
        
        
        case RestaurantDishes = "RestaurantDishes"
        case Cuisines = "Cuisines"
        case Facilities = "Facilities"
        
        
        case CityId = "CityId"
        case CityName = "CityName"
        case MinOrder = "MinOrder"
        case MinTime = "MinTime"
        case RestaurantImage = "RestaurantImage"
        case HomeDeliveryDistRange = "HomeDeliveryDistRange"
    }
}

struct MenuImages :Codable {
    var MenuImageName : String!
    
    enum CodingKeys : String, CodingKey {
        case MenuImageName = "MenuImageName"
    }
}

struct Cuisines :Codable {
    var Cuisine : String!
    
    enum CodingKeys : String, CodingKey {
        case Cuisine = "Cuisine"
    }
}

struct Facilities :Codable {
    var Facilities : String!
    var Values : Bool!
    enum CodingKeys : String, CodingKey {
        case Facilities = "Facilities"
        case Values = "Values"
    }
}

struct RestaurantDishes :Codable {
    var RestaurantDishId: Int!
    var RestaurantDishName: String!
    var Rank: Int!
    var Votes: String!
    var IsVeg: Int!
    var DishImage: String!
    var DishGlossary: Int!
    var FMUser: Int!
    var Friends: Int!
    var IsDishLike: Int!
    var DishSequence: Int!
    var Rate: String!
    
    enum CodingKeys : String, CodingKey {
        case RestaurantDishId = "RestaurantDishId"
        case RestaurantDishName = "RestaurantDishName"
        case Rank = "Rank"
        case Votes = "Votes"
        case IsVeg = "IsVeg"
        case DishImage = "DishImage"
        case DishGlossary = "DishGlossary"
        case FMUser = "FMUser"
        case Friends = "Friends"
        case IsDishLike = "IsDishLike"
        case DishSequence = "DishSequence"
        case Rate = "Rate"
    }
}





