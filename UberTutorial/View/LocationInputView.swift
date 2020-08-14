//
//  LocationInputView.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/11.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit

// protocol > HomeViewController 로 delegate 하여 기능 구현하기 위함!!
protocol LocationInputViewDelegate: class {
    func dismissLocationInputView()
}

//    MARK: Where To? indicator View를 클릭했을때 나타나는 상단 흰색 뷰

class LocationInputView: UIView {

    weak var delegate : LocationInputViewDelegate?
    
    //    MARK: Properties
    
    var user: User? {
        didSet {titleLabel.text = user?.fullname}
    }
    
    private let backButton : UIButton = {
        let button = UIButton()
        //withRenderingMode: 이미지를 Display에 나타낼때 (.alwaysOriginal : 원본이미지로 보여주기)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let startLocationIndicatiorView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationIndicatiorView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var startingLocationTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current Location"
        tf.backgroundColor = .groupTableViewBackground
        tf.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 30, width: 8)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.isEnabled = false
        
        return tf
    }()
    
    private lazy var destinationLocationTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a destination.."
        tf.backgroundColor = .lightGray
        tf.returnKeyType = .search
        tf.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 30, width: 8)
        tf.leftView = paddingView
        tf.leftViewMode = .always

        
        return tf
    }()

    
    
    
    
    //    MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addShadow()
        
        backgroundColor = .white
        
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft:  12, width: 24, height: 25)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: backButton)
        titleLabel.centerX(inView: self)
        
        addSubview(startingLocationTextField)
        startingLocationTextField.anchor(top: backButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 40,paddingRight: 40, height:  30)
        
        addSubview(destinationLocationTextField)
        destinationLocationTextField.anchor(top: startingLocationTextField.bottomAnchor, left:  leftAnchor,right: rightAnchor, paddingTop: 12, paddingLeft:  40, paddingRight: 40, height:  30)
        
        addSubview(startLocationIndicatiorView)
        startLocationIndicatiorView.centerY(inView: startingLocationTextField,leftAnchor: leftAnchor, paddingLeft:  20)
        startLocationIndicatiorView.setDimensions(height: 6, width: 6)
        startLocationIndicatiorView.layer.cornerRadius = 6 / 2
        
        addSubview(destinationIndicatiorView)
        destinationIndicatiorView.centerY(inView: destinationLocationTextField,leftAnchor: leftAnchor, paddingLeft:  20)
        destinationIndicatiorView.setDimensions(height: 6, width: 6)
        destinationIndicatiorView.layer.cornerRadius = 6 / 2
       
        addSubview(linkingView)
        linkingView.centerX(inView: startLocationIndicatiorView)
        linkingView.anchor(top: startLocationIndicatiorView.bottomAnchor, bottom: destinationIndicatiorView.topAnchor, paddingTop: 4, paddingBotton: 4, width:  0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 //    MARK: Selector
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
    
}
