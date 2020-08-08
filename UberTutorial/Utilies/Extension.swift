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

extension UIView {
    
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
    
    func centerY(inView view: UIView){
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
