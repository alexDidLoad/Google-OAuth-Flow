//
//  LoginVC.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let loginLabel = CustomBoldLabel(withTitle: "Login")
    
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureGoogleSignIn()
    }
    
    //MARK: - API
    
    private func configureGoogleSignIn() {
        
        GOOGLE_SIGNIN_ID.presentingViewController = self
        GOOGLE_SIGNIN_ID.delegate                 = self
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(loginLabel)
        loginLabel.centerX(inView: view)
        loginLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          paddingTop: 30)
        
        view.addSubview(googleOAuthButton)
        googleOAuthButton.centerX(inView: view)
        googleOAuthButton.centerY(inView: view, constant: -50)
        googleOAuthButton.setDimensions(height: 30, width: 150)
        
        view.addSubview(backButton)
        backButton.centerX(inView: view)
        backButton.setDimensions(height: 30, width: 150)
        backButton.anchor(top: googleOAuthButton.bottomAnchor, paddingTop: 15)
        
    }
    
    //MARK: - Selectors
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Authentication

extension LoginVC: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("DEBUG: Error signing user in: \(error.localizedDescription)")
        }

        if let user = user {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            
            AuthService.signInUser(withCredentials: credential) { currentUser in
                let destVC = FinalVC(currentUser: currentUser, credentials: credential)
                self.navigationController?.pushViewController(destVC, animated: true)
            }
        }
        
    }
    
}
