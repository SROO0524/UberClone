//
//  HomeController.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/10.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    //    MARK: Properties
    
    //    MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        view.backgroundColor = .red
    }
    
    //    MARK: API
    // 로그인이 되어 있으면 HomeVieW 로 이동하고, 로그인이 안되어 있으면 LoginView 나오게함.
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                self.present(nav, animated:  true, completion:  nil)
            }
        } else {
            print("DEBUG: User id is \(Auth.auth().currentUser?.uid)")
        }
    }
    
    //로그아웃
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: error Signing out")
        }
    }
}
