//
//  MapView+Extensions.swift
//  DDLite
//
//  Created by Jason wang on 6/23/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import MapKit

extension MKMapView {
    var centerLocation: CLLocation {
        return CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
    }
}
