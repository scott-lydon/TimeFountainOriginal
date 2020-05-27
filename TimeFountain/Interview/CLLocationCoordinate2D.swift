//
//  CLLocationCoordinate2D.swift
//  ScottLydon
//
//  Created by Scott Lydon on 10/2/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//


import Foundation
import CoreLocation


public extension CLLocationCoordinate2D {
    
    var json: [String: String] {
        return [
            "latitude": latitude.string,
            "longitude": longitude.string
        ]
    }
    
    static var currentLocation: CLLocationCoordinate2D? {
        return CLLocationManager().location?.coordinate
    }
    
    var nearby: CLLocationCoordinate2D? {
        guard let lat = CLLocationDegrees(exactly: latitude  + 0.01),
            let lon = CLLocationDegrees(exactly: longitude + 0.004) else {
                print("Error: Could not instantiate CllocationDegrees for some reason.")
                return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    

}
