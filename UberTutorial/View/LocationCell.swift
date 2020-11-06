//
//  LocationCell.swift
//  UberTutorial
//
//  Created by 김믿음 on 2020/08/11.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {

    //    MARK: properties
    
    //검색 후 테이블 뷰 셀안에 들어가는 데이터 세팅
    var placemark: MKPlacemark? {
        didSet {
            titlaLabel.text = placemark?.name
            addressLabel.text = placemark?.address
        }
    }
    
    private let titlaLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let addressLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    //    MARK: LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [titlaLabel,addressLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor:  leftAnchor, paddingLeft: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
