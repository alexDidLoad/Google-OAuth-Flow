//
//  CustomTextField.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit

class CustomTextField: UITextField {
    
    //MARK: - Init
    
    init(placeholder: String, isSecureEntry secure: Bool) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        
        leftView              = spacer
        leftViewMode          = .always
        borderStyle           = .none
        textColor             = .black
        keyboardAppearance    = .light
        keyboardType          = .emailAddress
        backgroundColor       = .systemGray5
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [ .foregroundColor : UIColor.systemGray2 ] )
        isSecureTextEntry     = secure
        setHeight(height: 50)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
