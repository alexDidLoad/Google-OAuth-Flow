//
//  CustomAuthButton.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit

class CustomAuthButton: UIButton {
    
    //MARK: - Init
    
    init(withTitle title: String, titleColor color: UIColor, backGroundColor: UIColor) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 2
        backgroundColor    = backGroundColor
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
