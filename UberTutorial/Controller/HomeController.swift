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

private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "DriverAnnotation"

class HomeController: UIViewController {
    
    //    MARK: Properties
    
    private let mapView = MKMapView()
    
    //현재 위치를 알리기 위해 변수 생성
    private let locationManager = Locationhandler.shared.locationManager
    
    // 지도 위에 검색 바 
    private let InputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    
    private var user : User? {
        didSet {locationInputView.user = user}
    }
    
    private final let locationInputViewHeight : CGFloat = 200
    
    //    MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        enableLocationSevices()
        checkIfUserIsLoggedIn()
        fetchUserData()
        fetchDrivers()
//        signOut()
    }
    
    //    MARK: API
    
    //Firebase에 이름을 가져오기 위해 fetch로 데이터에 접근해 fullname 정보를 가지고옴
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
        }
    }
    
    func fetchDrivers() {
        guard let location = locationManager?.location else { return }
        Service.shared.fetchDrivers(location: location) { (driver) in
            guard let coordinate = driver.location?.coordinate else { return }
            let annotation = DriverAnnotation(uid: driver.uid, coordinate: coordinate)
            
            // Driver의 위치가 변동되면 핀의 위치가 업데이트됨
            var driverIsVisible : Bool {
                return self.mapView.annotations.contains(where: {annotation -> Bool in
                    guard let driverAnno = annotation as? DriverAnnotation else { return false }
                    if driverAnno.uid == driver.uid {
                        driverAnno.updateAnnotationPosition(withCoordinate: coordinate)
                        return true
                    }
                    return false
                })
            }
            
            if !driverIsVisible {
              self.mapView.addAnnotation(annotation)
            }
            
        }
    }
    
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
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                self.present(nav, animated:  true, completion:  nil)
            }
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
        
        configureTableView()
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        // 현재 위치를 showsUserLocation 으로 파란색 닷으로 활성화
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        
    }
    
    // where to? Indicator 클릭시 나오는 View & 애니메이션 효과 주기
    func configureLocationInputView() {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1
        }) { _ in
            print("DEBUG: Present table view ..")
        // 상단 Indicator 가 뜬 후 아래 커스텀 tableView가 뜨도록 설정
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            })
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        // footterview: 5줄말 표현하려고 할때 아래 줄을 공백으로 두는것!!
        tableView.tableFooterView = UIView()
        
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height)
        
        
        view.addSubview(tableView)
    }
}

//    MARK: MKMapViewDelegate
 
// 지도 위 pin 이미지 커스텀하는 Delegate : Reusable Annotation 덕분에 매번 핀을 복사하여 사용하지 않아도 된다.
extension HomeController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier )
            view.image = #imageLiteral(resourceName: "chevron-sign-to-right")
            return view
        }
        return nil
    }
}

// MARK: LocationServices
extension HomeController  {
    
    func enableLocationSevices() {
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined: // 현재 위치를 찾을 수 없을때 위치 사용 권한을 요청함
            print("DEBUG: Not Determined..")
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways: // 위치를 항상 업데이트, 정확하게
            print("DEBUG: Auth always.")
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse: //사용 권한 설정 후에 앱이 사용중이지 않을때도 정보 줄래?
            print("DEBUG: Auth When in use..")
            locationManager?.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    //

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
        // 뒤로 가기 눌렀을때 table view 가 나오지 않도록
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        }){ _ in
            // 애니메이션이 끝나면 다시 inoputactivationView 가 나옴!!
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3, animations: {
                self.InputActivationView.alpha = 1})
        }
    }
    
    
}

//    MARK: UITableViewDelegate/DataSource

extension HomeController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 2
//        }
//
//        return 5 > 아래 코드와 동일한 내용임!!
        
        return section == 0 ? 2 : 5
    }
    
    // tableView cell 안에 들어갈 내용은!! 커스텀 셀!!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as!
        LocationCell
        return cell
    }
    
    
}
