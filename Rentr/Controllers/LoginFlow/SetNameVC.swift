//
//  SetNameVC.swift
//  Rentr
//
//  Created by Alexander Ha on 3/19/21.
//

import UIKit
import Firebase
import GoogleSignIn

class SetNameVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let titleLabel          = CustomBoldLabel(withTitle: "What's your name?")
    private let firstNameTextField  = CustomTextField(placeholder: "First Name", isSecureEntry: false)
    private let lastNameTextField   = CustomTextField(placeholder: "Last Name", isSecureEntry: false)
    
    private let continueButton: CustomAuthButton = {
        let button = CustomAuthButton(withTitle: "Continue", titleColor: .white, backGroundColor: UIColor.systemBlue.withAlphaComponent(0.47))
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: CustomAuthButton = {
        let button = CustomAuthButton(withTitle: "Cancel", titleColor: .white, backGroundColor: UIColor.systemGray2.withAlphaComponent(0.67))
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    private var authViewModel = RegistrationViewModel()
    var credentials: AuthCredential!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    convenience init(withCredentials credentials: AuthCredential) {
        self.init()
        self.credentials = credentials
    }
    
    //MARK: - Helpers
    
    private func configureNotificationObservers() {
        firstNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let padding: CGFloat = 32
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          paddingTop: 62,
                          paddingLeading: padding,
                          paddingTrailing: padding)
        
        let stack     = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, continueButton, cancelButton])
        stack.axis    = .vertical
        stack.spacing = 10
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor,
                     leading: titleLabel.leadingAnchor,
                     trailing: titleLabel.trailingAnchor,
                     paddingTop: padding)
    }
    
    
    //MARK: - Selectors
    
    @objc private func handleContinue() {
        //set the users first and last name here...
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName  = lastNameTextField.text else { return }
        guard let credentials = credentials else { return }
        
        AuthService.registerUser(withCredentials: credentials, firstName: firstName, lastName: lastName) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                print("DEBUG: failed to register user: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
    
    
    @objc private func handleCancel() {
        self.dismiss(animated: true)
    }
    
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == firstNameTextField {
            authViewModel.firstName = firstNameTextField.text
        } else {
            authViewModel.lastName = lastNameTextField.text
        }
        
        updateForm()
    }
    
}

//MARK: - Form validation

extension SetNameVC: FormViewModel {
    
    func updateForm() {
        continueButton.isEnabled       = authViewModel.formIsValid
        continueButton.backgroundColor = authViewModel.buttonBackgroundColor
    }
    
}
