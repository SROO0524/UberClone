//
//  User.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/14.
//  Copyright © 2020 김믿음. All rights reserved.
//
import CoreLocation


enum AccountType: Int {
    case passenger
    case driver
}

struct User {
    let fullname: String
    let email : String
    var accountType: AccountType!
    //손님과 기사 모두 이름, 이메일, 계정타입은 가지고 있지만 위치 정보는 있을수도 있고 없을수도 있기 떄문에 옵셔널 타입으로 지정
    var location : CLLocation?
    let uid : String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.fullname = dictionary["이름"] as? String ?? ""
        self.email = dictionary["이메일"] as? String ?? ""
        
        if let index = dictionary["accountType"] as? Int {
            self.accountType = AccountType(rawValue: index)
        }
        
    }
}
