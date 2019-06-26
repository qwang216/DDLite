//
//  DDGeocodService.swift
//  DDLite
//
//  Created by Jason wang on 6/23/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import Foundation
import CoreLocation

enum GeoCoderError: Error {
    case errorWith(msg: String)
}

extension GeoCoderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorWith(let msg):
            return msg
        }
    }
}

class DDGeocodeService {
    let geoCoder = CLGeocoder()
    func fetchAddressFrom(location: CLLocation, onComplete: @escaping (Result<String, GeoCoderError>) -> Void) {
        geoCoder.reverseGeocodeLocation(location) { (placemarks, err) in
            DispatchQueue.main.async {
            
            if let errMsg = err {
                onComplete(.failure(.errorWith(msg: "Unable to query address: error:  \(errMsg.localizedDescription)")))
                return
            }
            
            guard let placeMark = placemarks?.first else {
                onComplete(.failure(.errorWith(msg: "Unable to query address from place mark")))
                return
            }
            
            let streetNum = placeMark.subThoroughfare ?? ""
            let streetNam = placeMark.thoroughfare ?? ""
                onComplete(.success("\(streetNum) \(streetNam)"))
            }
        }
    }
}
