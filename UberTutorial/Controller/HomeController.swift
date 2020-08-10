//
//  HomeController.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/10.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    
    //    MARK: Properties
    
    private let mapView = MKMapView()
    
    //    MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
//        signOut()
    }
    
    //    MARK: API
    // 로그인이 되어 있으면 HomeVieW 로 이동하고, 로그인이 안되어 있으면 LoginView 나오게함.
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                self.present(nav, animated:  true, completion:  nil)
            }
        } else { // 로그인 되어 있을떄 MapView가 나타나도록 함
            configureUI()
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
    
    //    MARK: Helper Function
    func configureUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
}
