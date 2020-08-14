//
//  Locatiohandler.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/14.
//  Copyright © 2020 김믿음. All rights reserved.
//

import CoreLocation

class Locationhandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = Locationhandler()
    var locationManager: CLLocationManager!
    var location : CLLocation?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    
}
