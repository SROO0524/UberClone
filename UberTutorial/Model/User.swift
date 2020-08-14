//
//  User.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/14.
//  Copyright © 2020 김믿음. All rights reserved.
//

struct User {
    let fullname: String
    let email : String
    let accountType: Int
    
    init(dictionary: [String: Any]) {
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? Int ?? 0
        
    }
}
