//
//  MapPin.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import Foundation
import MapKit

// MARK: Artwork
class Artwork: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
}
