//
//  FormatedAddressResponse.swift
//  ShawManApp
//
//  Created by Jai Mataji on 24/02/21.
//

import Foundation

struct FormatedAddressResponse :Codable {
    var FullAddress :String!
    var CityId :Int!
    var CityName :String!
    var CountryName :String!
    var CountryId :Int!
    var Message :String!
    
    enum CodingKeys: String, CodingKey {
        case FullAddress = "FullAddress"
        case CityId = "CityId"
        case CityName = "CityName"
        case CountryName = "CountryName"
        case CountryId = "CountryId"
        case Message = "Message"
    }
}

