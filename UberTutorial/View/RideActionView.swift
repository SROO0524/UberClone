//
//  RideActionView.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/09/03.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import MapKit


protocol RideActionViewDelegate: class {
    func uploadTrip(_ view: RideActionView)
}

class RideActionView: UIView {

//    MARK: Properties
    
    // titlelabel 과 addressLabel에 선택된 실제 데이터를 넘겨줌!
    var destination : MKPlacemark? {
        didSet {
            titleLabel.text = destination?.name
            addressLabel.text = destination?.address
        }
    } 
    
    weak var delegete : RideActionViewDelegate?
    
   private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Test Address Title"
        label.textColor = .black
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

    private let uberXLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "UberX"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let actionButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("현재위치 확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
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
        
        addSubview(uberXLabel)
        uberXLabel.anchor(top: infoview.bottomAnchor, paddingTop: 8)
        uberXLabel.centerX(inView: self)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = .lightGray
        addSubview(seperatorView)
        seperatorView.anchor(top: uberXLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, height: 0.75)
        
        addSubview(actionButton)
        actionButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 12, paddingBotton: 12, paddingRight: 12, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Delegate 를 발생시키는 곳
    @objc func actionButtonPressed() {
        delegete?.uploadTrip(self)
    }
    
}
