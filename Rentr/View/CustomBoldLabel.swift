//
//  CustomBoldLabel.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit

class CustomBoldLabel: UILabel {
    
    //MARK: - Init
    
    init(withTitle title: String) {
        super.init(frame: .zero)
        
       text      = title
       textColor = .black
       font      = UIFont.boldSystemFont(ofSize: 32)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
