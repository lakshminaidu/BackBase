//
//  MapDetailViewModel.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 11/7/21.
//

import Foundation
import CoreLocation
import MapKit

// MARK: MapDetailViewModelType
protocol MapDetailViewModelType {
    var city: City? {get set}
    var region: MKCoordinateRegion? {get}
    func mapPin() -> Artwork?
}

// MARK: Ext MapDetailViewModelType
extension MapDetailViewModelType {
    
    func mapPin() -> Artwork? {
        if let city = self.city {
            return  Artwork(
                title: city.title,
                coordinate: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon))
        } else {
           return nil
        }
        
    }
    
    var region: MKCoordinateRegion? {
        if let city = self.city {
            return MKCoordinateRegion(
                center: city.location.coordinate,
                latitudinalMeters: 5000,
                longitudinalMeters: 6000)
        } else {
            return nil
        }
    }
}

// MARK: MapDetailViewModel
class MapDetailViewModel: MapDetailViewModelType {
    var city: City?
    init( with city: City?) {
        self.city = city
    }
}
