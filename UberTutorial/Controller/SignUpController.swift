//
//  SignUpController.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/08.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase
import GeoFire

class SignUpController : UIViewController {
    
//    MARK: Properties
    
    private var location = Locationhandler.shared.locationManager.location
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()

    
    private let emailTextField : UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEentry: false)
    }()
    
    private let fullNameTextField : UITextField = {
           return UITextField().textField(withPlaceholder: "Full Name", isSecureTextEentry: false)
       }()
    
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: passWordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_account_box_white_2x"), segmentedControl: accountTypeSegmentControl)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    
    
    private let passWordTextField : UITextField = {
        return UITextField().textField(withPlaceholder: "PassWord", isSecureTextEentry: true)
    }()
    
    private let accountTypeSegmentControl : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let signUPButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
           let button = UIButton(type: .system)
           
           let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
               NSAttributedString.Key.foregroundColor: UIColor.lightGray])
           
           attributedTitle.append(NSAttributedString(string: "Log In", attributes:
               [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.mainBlue]))
           
           button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
           
           
           button.setAttributedTitle(attributedTitle, for: .normal)
           return button
       }()


//    MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
        
    }
    
// MARK: Selector & @objc
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else {return}
        guard let password = passWordTextField.text else {return}
        guard let fullname = fullNameTextField.text else {return}
        let accountTypeIndex = accountTypeSegmentControl.selectedSegmentIndex
        
        print(email)
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: failed to register user with error\(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email" : email, "fullname" : fullname, "accountType" : accountTypeIndex] as [String : Any]
            
//            var geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
            
            // accountType이 1일 경우 ( Driver 일경우 , 아래와 같이 위치 정보를 받아온다)
            if accountTypeIndex == 1{
                let geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
                guard let location = self.location else {return}
                geofire.setLocation(location, forKey: uid) { (error) in
                    self.uploadUserDataAndShowHomeController(uid: uid, values: values)
                }
                
            }
            
            self.uploadUserDataAndShowHomeController(uid: uid, values: values)
            
            
        }
    }
    
// MARK: Helper Functions
    
    func uploadUserDataAndShowHomeController(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            guard let controller = UIApplication.shared.keyWindow?.rootViewController as? HomeController else {return}
            controller.configure()
            self.dismiss(animated: true, completion: nil)
        }

        
    }
    
    
    func configureUI() { // viewdidLoad 안에 있는 코드를 하단 func 으로 따로 빼서 코드의 간소화함. 전보다 보기 훨씬편함!!

        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,fullNameContainerView,passwordContainerView,accountTypeContainerView,signUPButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop:  40, paddingLeft:  16, paddingRight:  16)
        
     view.addSubview(alreadyHaveAccountButton)
     alreadyHaveAccountButton.centerX(inView: view)
     alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        
    }
    
}
