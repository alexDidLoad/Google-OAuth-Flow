//
//  AuthViewModel.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

struct RegistrationViewModel {
    var firstName : String?
    var lastName  : String?
    
    var formIsValid: Bool {
        return firstName?.isEmpty == false && lastName?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor.systemBlue : UIColor.systemBlue.withAlphaComponent(0.47)
    }
    
}
