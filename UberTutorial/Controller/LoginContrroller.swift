//
//  LoginContrroller.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/07.
//  Copyright © 2020 김믿음. All rights reserved.
//


import UIKit
import Firebase


class LoginController: UIViewController {

    
// MARK: Properties
    
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
    
    private let emailTextField : UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEentry: false)
    }()
    
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: passWordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let passWordTextField : UITextField = {
        return UITextField().textField(withPlaceholder: "PassWord", isSecureTextEentry: true)
    }()
    

    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    
// 하단에 가입 버튼 만들기
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes:
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor: UIColor.mainBlue]))
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
// MARK: Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    

    
// MARK: Selectors / Actions
    
    @objc func handleShowSignUp(){
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let password = passWordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG:Failed to log user in with error \(error.localizedDescription)")
                return
            }
            // 로그인에 성공하면 로그인 화면이 Dismiss 되고 , rootviewController 를 HomeController로 받아서 HomeController View가 나옴!
            guard let controller = UIApplication.shared.keyWindow?.rootViewController as? HomeController else {return}
            controller.configure()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//    MARK: Helper Functions
    func configureUI() { // viewdidLoad 안에 있는 코드를 하단 func 으로 따로 빼서 코드의 간소화함. 전보다 보기 훨씬편함!!
        configureNavigationBar() //navigationController 속성안에 configureNavigation 속성을 넣어 코드를 간편하게 만듬
        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50 )
        
        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 50 )
        
// StackView 생성: emailContainerView,passwordContainerView,loginButton 스택뷰로 묶음
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop:  40, paddingLeft:  16, paddingRight:  16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}
