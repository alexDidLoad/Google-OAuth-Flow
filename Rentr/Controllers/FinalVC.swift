//
//  FinalVC.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit
import Firebase

class FinalVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let finalScreenLabel = CustomBoldLabel(withTitle: "Final Screen")
    private let displayNameLabel = CustomBoldLabel(withTitle: "Display Name")
    
    private let signOutButton: CustomAuthButton = {
        let button = CustomAuthButton(withTitle: "Sign Out", titleColor: .white, backGroundColor: .systemRed)
        button.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    private var credentials: AuthCredential!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        checkForFirstLastName()
    }
    
    convenience init(currentUser user: User, credentials: AuthCredential) {
        self.init()
        self.credentials      = credentials
        displayNameLabel.text = user.email
    }
    
    //MARK: - Helpers
    
    private func checkForFirstLastName() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        AuthService.checkIfUserHasFirstLastName(uid) { [weak self] exists in
            guard let self = self else { return }
            
            if exists {
                return
            } else {
                let destVC = SetNameVC(withCredentials: self.credentials)
                destVC.modalPresentationStyle = .fullScreen
                self.present(destVC, animated: true)
            }
        }
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(finalScreenLabel)
        finalScreenLabel.centerX(inView: view)
        finalScreenLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                paddingTop: 30)
        
        view.addSubview(displayNameLabel)
        displayNameLabel.centerX(inView: view)
        displayNameLabel.centerY(inView: view, constant: -50)
        
        view.addSubview(signOutButton)
        signOutButton.centerX(inView: view)
        signOutButton.setDimensions(height: 30, width: 124)
        signOutButton.anchor(top: displayNameLabel.bottomAnchor,
                             paddingTop: 48)
    }
    
    //MARK: - Selectors
    
    @objc private func handleSignOut() {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("DEBUG: Failed to sign user out")
        }
        
    }
    
}
