//
//  Citi.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import Foundation
import CoreLocation

// MARK: - City
struct City: Codable {
    var country: String
    var name: String
    var id: Int
    var coord: Coord
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coord
    }
}

// MARK: - Coord
struct Coord: Codable {
    var lon: Double
    var lat: Double
}

extension City {
    
    var title: String {
        return name + ", " + country
    }
    
    var subTitle: String {
        return "lat: \(coord.lat.description )" + ", " + "lon: \(coord.lon.description )"
    }
    
    var location: CLLocation {
        return CLLocation(latitude: coord.lat, longitude: coord.lon)
    }
    
}


