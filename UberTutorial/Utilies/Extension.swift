//
//  Extension.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/07.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
// extention 을 UIView 로 설정하면 UIKit 안에 있는 모든 기능에서 내가 설정한 아래의
// 기능을 마음대로 가져다 쓸수 있다! **핵신기**
// 아래 코드는 어느 코드에서든 자유롭게 사용가능함!! 다른 프로젝트에도 붙여쓰면된다아~

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let mainBlue = UIColor.rgb(red: 17, green: 154, blue: 237)
}

extension UIView {
    
    func inputContainerView(image: UIImage, textField: UITextField? = nil, segmentedControl: UISegmentedControl? = nil) -> UIView {
        let view = UIView()
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        view.addSubview(imageView)
        
        if let textField = textField {
            imageView.centerY(inView: view)
            imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24 , height: 24)
            
            view.addSubview(textField)
            textField.centerY(inView: view)
            textField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBotton:  8)
        }
        
        if let sc = segmentedControl {
            imageView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop:  -8 ,paddingLeft: 8, width: 24, height: 24)
            
            view.addSubview(sc)
            sc.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight:  8 )
            sc.centerY(inView: view, constant: 8)
            
        }
        
        
        
// 로그인 아래 선 
        
        
        let seperateView = UIView()
        seperateView.backgroundColor = .lightGray
        view.addSubview(seperateView)
        seperateView.anchor(left: view.leftAnchor, bottom:  view.bottomAnchor, right: view.rightAnchor, paddingLeft:
            9, height: 0.75)
        
        return view
        
    }
    //nil 값을 준이유: 각 ui 마다 필요한 anchor를 제외하고는 값을 따로 주지 않아도 되는 경우가 있는데 이 경우를 위해 nil 값으로 설정
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBotton: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        // 화면상에서 + 하게 되면 왼쪽화면을 기준으로 화면에서 보이지 않는 왼쪽으로 향하기 때문에 - 해야함!
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBotton).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

    }
    
    func centerX(inView view: UIView){
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView , constant: CGFloat = 0){
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:  constant).isActive = true
    }

}

// MARK: 로그인/회원가입 필드에서 중복되는 코드 최소화 하기 위해 Extension을 따로 만들어줌
extension UITextField {
    
    func textField(withPlaceholder placeholder: String, isSecureTextEentry: Bool) -> UITextField {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.isSecureTextEntry = isSecureTextEentry
        //custom placeholder 하는 방법
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return tf
    }
}
