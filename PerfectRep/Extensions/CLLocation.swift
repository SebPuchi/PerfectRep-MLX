//
//  CLLocation.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import CoreLocation

extension CLLocation {
    
    func replacing(latitude: CLLocationDegrees? = nil, longitude: CLLocationDegrees? = nil, altitude: CLLocationDistance? = nil, horizontalAccuracy: CLLocationAccuracy? = nil, verticalAccuracy: CLLocationAccuracy? = nil, course: CLLocationDirection? = nil, speed: CLLocationSpeed? = nil, timeStamp: Date? = nil) -> CLLocation {
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude ?? self.coordinate.latitude, longitude: longitude ?? self.coordinate.longitude)
        
        return CLLocation(coordinate: coordinate, altitude: altitude ?? self.altitude, horizontalAccuracy: horizontalAccuracy ?? self.horizontalAccuracy, verticalAccuracy: verticalAccuracy ?? self.verticalAccuracy, course: course ?? self.course, speed: speed ?? self.speed, timestamp: timeStamp ?? self.timestamp)
    }
    
}

