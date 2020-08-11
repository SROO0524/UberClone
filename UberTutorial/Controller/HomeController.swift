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
    
    //현재 위치를 알리기 위해 변수 생성
    private let locationManager = CLLocationManager()
    
    // 지도 위에 검색 바 
    private let InputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    
    //    MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        enableLocationSevices()
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
        configureMapView()
        
        view.addSubview(InputActivationView)
        InputActivationView.centerX(inView: view)
        InputActivationView.setDimensions(height: 50, width: view.frame.width - 64)
        InputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        InputActivationView.alpha = 0
        InputActivationView.delegate = self
        
        //Indicator 에 애니메이션 주기! 
        UIView.animate(withDuration: 2) {
            self.InputActivationView.alpha = 1
        }
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        // 현재 위치를 showsUserLocation 으로 파란색 닷으로 활성화
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
    }
    
    // where to? Indicator 클릭시 나오는 View & 애니메이션 효과 주기
    func configureLocationInputView() {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor,height:  200)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1
        }) { _ in
            print("DEBUG: Present table view ..")
            
        }
    }
}
 
// MARK: LocationServices
extension HomeController : CLLocationManagerDelegate {
    
    
    func enableLocationSevices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined: // 현재 위치를 찾을 수 없을때 위치 사용 권한을 요청함
            print("DEBUG: Not Determined..")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways: // 위치를 항상 업데이트, 정확하게
            print("DEBUG: Auth always.")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse: //사용 권한 설정 후에 앱이 사용중이지 않을때도 정보 줄래?
            print("DEBUG: Auth When in use..")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    //
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

//    MARK: LocationInputActivationViewDelegate


extension HomeController: LocationInputActivationViewDelegate {
    func presentLocationInputView() {
        
        InputActivationView.alpha = 0
        configureLocationInputView()
    }
 
}

extension HomeController : LocationInputViewDelegate {
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.3, animations: {self.locationInputView.alpha = 0
        }){ _ in
            // 애니메이션이 끝나면 다시 inoputactivationView 가 나옴!!
            UIView.animate(withDuration: 0.3, animations: {self.InputActivationView.alpha = 1})
        }
    }
    
    
}
