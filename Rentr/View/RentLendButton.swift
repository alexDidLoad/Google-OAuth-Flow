//
//  RentLendButton.swift
//  Rentr
//
//  Created by Alexander Ha on 3/22/21.
//

import UIKit

class RentLendButton: UIButton {
    
    //MARK: - Properties
    
    private let dimension: CGFloat = 125
    
    //MARK: - Init
    
    init(withTitle title: String, buttonColor: UIColor) {
        super.init(frame: .zero)
     
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        backgroundColor  = buttonColor
        
        setDimensions(height: dimension, width: dimension)
        layer.cornerRadius = dimension / 2
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
