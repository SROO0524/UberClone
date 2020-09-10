//
//  RideActionView.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/09/03.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit

class RideActionView: UIView {

//    MARK: Properties
    
   private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Test Address Title"
        label.textAlignment = .center
        return label
    }()
    
   private let addressLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "123 M St, NW Wqshington"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var infoview : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.text = "X"
        
        view.addSubview(label)
        label.centerX(inView: view)
        label.centerY(inView: view)
        return view
    }()

    
    
    
    
//    MARK:  LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addShadow()
        
        let stack = UIStackView(arrangedSubviews: [titleLabel,addressLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: topAnchor, paddingTop:  12)
        
        addSubview(infoview)
        infoview.centerX(inView: self)
        infoview.anchor(top: stack.bottomAnchor, paddingTop: 16)
        infoview.setDimensions(height: 60, width: 60)
        infoview.layer.cornerRadius = 60/2
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
