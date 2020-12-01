//
//  Trips.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/12/01.
//  Copyright © 2020 김믿음. All rights reserved.
//

import CoreLocation

//    MARK: Trip model

struct Trip {
    
    var pickupCoordinates : CLLocationCoordinate2D!
    var destinationCoordinates : CLLocationCoordinate2D!
    let passengerUid : String
    var driverUid : String?
    var state : TripState!
    
    init(passengerUid : String, dictionary : [String : Any]) {
        self.passengerUid = passengerUid
        
        if let pickupCoordinates = dictionary["pickupCoordinates"] as? NSArray {
            guard let lat = pickupCoordinates[0] as? CLLocationDegrees else { return }
            guard let long = pickupCoordinates[1] as? CLLocationDegrees else { return }
            self.pickupCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        if let destinationCoodinates = dictionary["pickupCoordinates"] as? NSArray {
            guard let lat = destinationCoodinates[0] as? CLLocationDegrees else { return }
            guard let long = destinationCoodinates[1] as? CLLocationDegrees else { return }
            self.destinationCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        self.driverUid = dictionary["driverUid"] as? String ?? ""
        
        if let state = dictionary["state"] as? Int {
            self.state = TripState(rawValue: state)
        }
    }
    
}

enum TripState : Int {
    case requested
    case accepted
    case inProgress
    case completed
}
