//
//  RegistrationVC.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit
import Firebase
import GoogleSignIn

class RegistrationVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let registrationLabel   = CustomBoldLabel(withTitle: "Register")
    
    private let googleOAuthButton : GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .wide
        return button
    }()
    
    private let backButton: UIButton = {
        let button = CustomAuthButton(withTitle: "Back", titleColor: .white, backGroundColor: UIColor.systemGray2.withAlphaComponent(0.67))
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    private var authViewModel = RegistrationViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureGoogleSignIn()
    }
    
    //MARK: - Helpers
    
    private func configureGoogleSignIn() {
        
        GOOGLE_SIGNIN_ID.presentingViewController = self
        GOOGLE_SIGNIN_ID.delegate                 = self
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(registrationLabel)
        registrationLabel.centerX(inView: view)
        registrationLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 paddingTop: 30)
        
        view.addSubview(googleOAuthButton)
        googleOAuthButton.centerX(inView: view)
        googleOAuthButton.centerY(inView: view, constant: -50)
        googleOAuthButton.setDimensions(height: 30, width: 150)
        
        view.addSubview(backButton)
        backButton.centerX(inView: view)
        backButton.anchor(top: googleOAuthButton.bottomAnchor,
                          paddingTop: 15,
                          width: 150)
    }
    
    //MARK: - Selectors
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - API

extension RegistrationVC: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("DEBUG: Error signing user in: \(error.localizedDescription)")
        }
        
        if let user = user {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            
            AuthService.checkIfAccountExists(credential) { [weak self] accountExists in
                guard let self = self else { return }
                
                if accountExists {
                    let alert = UIAlertController(title: "Account Exists", message: "Use Login instead", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default))
                    self.present(alert, animated: true)
                } else {
                    let destVC = RegisterNameVC(withCredentials: credential)
                    self.navigationController?.pushViewController(destVC, animated: true)
                }
            }
        }
    }
    
    
}
