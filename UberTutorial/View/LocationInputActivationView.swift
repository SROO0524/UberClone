//
//  LocationInputActivationView.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/10.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit

// Delgate 에서 쓸 기능을 Protocol 로 정의해둘테니 Delegate 받을때 꼭 아래 func 을 구현해줘!!!
protocol LocationInputActivationViewDelegate : class {
    func presentLocationInputView()
}

class LocationInputActivationView : UIView {
    
    //    MARK: Properties
    // Delegate 를 쓰는이유! : UIView에서는 view를 띄울수 있는 presenting 기능을 쓸수 없기 때문에 HomeViewController에서 LocationInputActivationView의 Delegate를 받아서 view를 띄운다
    
    weak var delegate: LocationInputActivationViewDelegate?
    
    private let indicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "어디로 갈까요?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    
    //    MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .white
        
        addShadow()
        
        addSubview((indicatorView))
        indicatorView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        indicatorView.setDimensions(height: 6, width: 6)
        
        
        addSubview(placeholderLabel)
        placeholderLabel.centerY(inView: self, leftAnchor: indicatorView.rightAnchor, paddingLeft: 20)
        
        //Indicator 를 Tap 했을때 액션 주기
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
         
    //    MARK:  Selectors
    
    
    @objc func presentLocationInputView(){
        delegate?.presentLocationInputView()
    }
    
    
    
}
