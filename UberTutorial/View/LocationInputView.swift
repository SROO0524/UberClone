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
    
    private let backButton : UIButton = {
        let button = UIButton()
        //withRenderingMode: 이미지를 Display에 나타낼때 (.alwaysOriginal : 원본이미지로 보여주기)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    //    MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addShadow()
        
        backgroundColor = .white
        
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft:  12, width: 24, height: 25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 //    MARK: Selector
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
    
}
