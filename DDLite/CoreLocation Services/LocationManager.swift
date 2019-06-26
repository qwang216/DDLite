//
//  LocationManager.swift
//  DDLite
//
//  Created by Jason wang on 6/23/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import CoreLocation

enum DeviceLocationStatus {
    case notEnabled
    case restricted
    case denied
    case unknown
}

protocol LocationManagerDelegate: class {
    func updateUserLocationAt(location: CLLocation?)
    func deviceLocationStatus(_ status: DeviceLocationStatus)
}

class LocationManager: NSObject {
    let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?

    func checkLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            delegate?.deviceLocationStatus(.notEnabled)
            return
        }
        setupLocationManager()
        checkLocationAuthorization()
    }
    
    fileprivate func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    fileprivate func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            delegate?.updateUserLocationAt(location: locationManager.location)
            locationManager.startUpdatingLocation()
        case .denied:
            delegate?.deviceLocationStatus(.denied)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            delegate?.deviceLocationStatus(.restricted)
        case .authorizedAlways:
            // this will never happen because we're not requesting for always
            //delegate?.updateUserLocationAt(locationManager.location?.coordinate)
            //locationManager.startUpdatingLocation()
            break
        @unknown default:
            delegate?.deviceLocationStatus(.unknown)
            fatalError("Location Services need to implement unknow case")
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
