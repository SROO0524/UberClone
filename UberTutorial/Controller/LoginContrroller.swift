//
//  LoginContrroller.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/07.
//  Copyright © 2020 김믿음. All rights reserved.
//

import Foundation
import UIKit

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
        let view = UIView()

        let imageView = UIImageView()
        // imageLiteral 은 프로젝트 내 asset에 이미지가 있을때 사용가능함! 더블클릭해서 원하는 이미지 넣기.
        imageView.image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24 , height: 24)

        view.addSubview(emailTextField)
        emailTextField.centerY(inView: view)
        emailTextField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBotton:  8)
        
// LoginTextField 아래 선
        let seperateView = UIView()
        seperateView.backgroundColor = .lightGray
        view.addSubview(seperateView)
        seperateView.anchor(left: view.leftAnchor, bottom:  view.bottomAnchor, right: view.rightAnchor, paddingLeft:
            9, height: 0.75)
        
        return view
    }()
    
    private let emailTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        //custom placeholder 하는 방법
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return tf
    }()
    
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()

        let imageView = UIImageView()
        // imageLiteral 은 프로젝트 내 asset에 이미지가 있을때 사용가능함! 더블클릭해서 원하는 이미지 넣기.
        imageView.image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24 , height: 24)

        view.addSubview(passWordTextField)
        passWordTextField.centerY(inView: view)
        passWordTextField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBotton:  8)
        
// LoginTextField 아래 선
        let seperateView = UIView()
        seperateView.backgroundColor = .lightGray
        view.addSubview(seperateView)
        seperateView.anchor(left: view.leftAnchor, bottom:  view.bottomAnchor, right: view.rightAnchor, paddingLeft:
            9, height: 0.75)
        
        return view
    }()
    
    private let passWordTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.isSecureTextEntry = true
        //custom placeholder 하는 방법
        tf.attributedPlaceholder = NSAttributedString(string: "PassWord", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return tf
    }()
    
// MARK: Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)

        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50 )
        
        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 50 )
        
    }
    
     // 상단 상태바 글자 흰색으로 바꾸기
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
