//
//  MainVC.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit

class MainVC: UIViewController {
    
    private let homeLabel = CustomBoldLabel(withTitle: "Home")
    
    
    private let loginButton: CustomAuthButton = {
        let button                = CustomAuthButton(withTitle: "Login", titleColor: .white, backGroundColor: .systemBlue)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: CustomAuthButton = {
        let button                = CustomAuthButton(withTitle: "Sign up", titleColor: .white, backGroundColor: UIColor.systemGray2.withAlphaComponent(0.67))
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(homeLabel)
        homeLabel.centerX(inView: view)
        homeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         paddingTop: 30)
        
        view.addSubview(loginButton)
        loginButton.centerX(inView: view)
        loginButton.centerY(inView: view, constant: -50)
        loginButton.setDimensions(height: 30, width: 140)
        
        view.addSubview(signUpButton)
        signUpButton.centerX(inView: view)
        signUpButton.setDimensions(height: 30, width: 140)
        signUpButton.anchor(top: loginButton.bottomAnchor, paddingTop: 15)
    }
    
    //MARK: - Selectors
    
    @objc private func handleLogin() {
        //present LoginVC here
        let destVC = LoginVC()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    @objc private func handleSignUp() {
        //present RegistrationVC here
        let destVC = RegistrationVC()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
}
