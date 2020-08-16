//
//  Service.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/11.
//  Copyright © 2020 김믿음. All rights reserved.
//

import Firebase
import GeoFire

let DB_REF = Database.database().reference()
// REF_USERS >> DB에 있는 Reference 중에 Child 데이터 중에서 users 를 찾아라!
let REF_USERS = DB_REF.child("users")

// REF_USERS >> DB에 있는 Reference 중에 Child 데이터 중에서 driverLocation 를 찾아라!
let REF_DRIVER_LOCATIONS = DB_REF.child("driver-locations")

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
}
