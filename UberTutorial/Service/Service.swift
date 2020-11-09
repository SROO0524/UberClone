//
//  Service.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/11.
//  Copyright © 2020 김믿음. All rights reserved.
//

import Firebase
import GeoFire
import FirebaseAuth

let DB_REF = Database.database().reference()
// REF_USERS >> DB에 있는 Reference 중에 Child 데이터 중에서 users의 정보를 저장하는 Directory
let REF_USERS = DB_REF.child("users")

// REF_USERS >> DB에 있는 Reference 중에 Child 데이터 중에서 driverLocation의 위치를 저장하는 Directory
let REF_DRIVER_LOCATIONS = DB_REF.child("driver-locations")

// REF_TRIPS >> DB에 사용자의 위치정보와 도착지 정보를 임시로 저장할 Directory
let REF_TRIPS = DB_REF.child("trips")

struct Service {
    // Firebase에 저장된 내 정보는 한번만 불러오면 되기 때문에 Service를 static let 으로 인스턴스화 한 후 사용!
    static let shared = Service()
    
    
    func fetchUserData(uid: String, completion: @escaping(User) -> Void) {
        // 현재 로그인한 사용자의 정보만 가져오기 위해서!!
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    func fetchDrivers(location: CLLocation, completion : @escaping(User) -> Void){
        let geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
        
        REF_DRIVER_LOCATIONS.observe(.value) { (snapshot) in
            geofire.query(at: location, withRadius: 50).observe(.keyEntered, with: {(uid, location) in
                self.fetchUserData(uid: uid, completion: { (user) in
                    var driver = user
                    driver.location = location
                    completion(driver)
                })
                
            })
        }
    }
    
    // 도착지 정보와 현재 위치 정보를 경로화 하여 Firebase Database 에 upload
    func uploadTrip(_ pickupCoordinates : CLLocationCoordinate2D, _ destinationCoordinates: CLLocationCoordinate2D, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let pickupArray = [pickupCoordinates.latitude, pickupCoordinates.longitude]
        let destinationArray = [destinationCoordinates.latitude, destinationCoordinates.longitude]
        
        let values = ["pickupCoordinates": pickupArray,
                      "destinationCoordinates": destinationArray]
        
        REF_TRIPS.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    
}
