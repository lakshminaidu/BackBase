//
//  LocationService.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import Foundation
import CoreLocation

// MARK: GeoLocationManager
class GeoLocationManager: NSObject {
    
    // MARK: - Varibales
    static let shared = GeoLocationManager()
    var geoLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    /// Used to get the current location code of the user
    var countryCode: String?
    
    
    static var isLocationServicesEnabled: Bool {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        return (CLLocationManager.locationServicesEnabled() &&
                    (authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways))
    }
    
    // MARK: - initializers
    override init() {
        super.init()
        locationManagerConfiguration()
    }
    
    // MARK: - user defined functions
    
    // configuring location manager
    func locationManagerConfiguration() {
        self.geoLocationManager.requestWhenInUseAuthorization()
        geoLocationManager.delegate = self
        geoLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        // geoLocationManager.pausesLocationUpdatesAutomatically = false
        // geoLocationManager.allowsBackgroundLocationUpdates = true
        stopMonitoringRegions()
    }
    
    // will start location updates
    func startUpdatingLocation() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            geoLocationManager.requestWhenInUseAuthorization()
        } else if GeoLocationManager.isLocationServicesEnabled {
            geoLocationManager.startUpdatingLocation()
        } else {
            // location services are deinied oe restricted
        }
    }
    
    // will stop location updates
    func stopUpdatingLocation() {
        geoLocationManager.stopUpdatingLocation()
    }
    
    /// This Method is used to get the Country code of the Location
    /// - Parameter completionHandler: Returns the Country Code
    func getCountryName( completionHandler: @escaping (String?) -> Void) {
        if let currentLocation = self.currentLocation {
            CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
                if let error = error {
                    debugPrint("Unable to Reverse Geocode Location (\(error))")
                    completionHandler(nil)
                } else {
                    if let placemarks = placemarks, let placemark = placemarks.first,
                       let countryCode = placemark.country {
                        completionHandler(countryCode)
                    } else {
                        completionHandler(nil)
                    }
                }
            }
        } else {
            completionHandler(nil)
        }
    }
    
    // MARK: - Helper
    func startMonitoring(region: CLRegion) {
        var isAlreadyMonitoring = false
        for item in geoLocationManager.monitoredRegions {
            if item.identifier == region.identifier {
                isAlreadyMonitoring = true
            }
        }
        if !isAlreadyMonitoring {
            geoLocationManager.startMonitoring(for: region)
        }
    }
    
    func stopMonitoringRegions() {
        for item in geoLocationManager.monitoredRegions {
            self.stopMonitoringRegion(region: item)
        }
    }
    
    func stopMonitoringRegion(region: CLRegion) {
        geoLocationManager.stopMonitoring(for: region)
    }
    
}

extension GeoLocationManager: CLLocationManagerDelegate {
    
}
