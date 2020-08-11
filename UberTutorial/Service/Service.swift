//
//  Service.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/11.
//  Copyright © 2020 김믿음. All rights reserved.
//

import Firebase

let DB_REF = Database.database().reference()
// REF_USERS >> DB에 있는 Reference 중에 Child 데이터 중에서 users 를 찾아라!
let REF_USERS = DB_REF.child("users")

struct Service {
    // Firebase에 저장된 내 정보는 한번만 불러오면 되기 때문에 Service를 static let 으로 인스턴스화 한 후 사용!
    static let shared = Service()
    let currentUid = Auth.auth().currentUser?.uid
    
    func fetchUserData() {
        // 현재 로그인한 사용자의 정보만 가져오기 위해서!!
        print("DEBUG: Current uid is \(currentUid)")
        REF_USERS.child(currentUid!).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let fullname = dictionary["fullname"] as? String else {return}
            print("DEBUG: User full name is \(fullname)")
        }
    }
}
