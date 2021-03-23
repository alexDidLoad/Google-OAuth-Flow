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
    
    private let displayNameLabel = CustomBoldLabel(withTitle: "Display Name")
    
    private let rentButton: RentLendButton = {
        let button = RentLendButton(withTitle: "Rent", buttonColor: .systemGreen)
        button.addTarget(self, action: #selector(handleRentTapped), for: .touchUpInside)
        return button
    }()
    
    private let lendButton: RentLendButton = {
        let button = RentLendButton(withTitle: "Lend", buttonColor: .systemOrange)
        button.addTarget(self, action: #selector(handleLendTapped), for: .touchUpInside)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    convenience init(currentUser user: User, credentials: AuthCredential) {
        self.init()
        self.credentials      = credentials
        title                 = user.displayName
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
    
    
    private func configureNavBar() {
        navigationController?.navigationBar.isHidden           = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton                         = true
        navigationItem.rightBarButtonItem                      = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleSignOut))
    }
    
    
    private func configureUI() {
        configureNavBar()
        
        view.backgroundColor = .white
        
        view.addSubview(rentButton)
        rentButton.centerY(inView: view)
        rentButton.anchor(leading: view.leadingAnchor,
                          paddingLeading: 25)
        
        view.addSubview(lendButton)
        lendButton.centerY(inView: view)
        lendButton.anchor(trailing: view.trailingAnchor,
                          paddingTrailing: 25)
    }
    
    //MARK: - Selectors
    
    @objc private func handleRentTapped() {
        print("rent")
    }
    
    
    @objc private func handleLendTapped() {
        print("lend")
    }
    
    
    @objc private func handleSignOut() {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("DEBUG: Failed to sign user out")
        }
    }
    
}
