//
//  AuthService.swift
//  Rentr
//
//  Created by Alexander Ha on 3/18/21.
//

import UIKit
import Firebase

struct AuthService {
    
    static func signInUser(withCredentials credentials: AuthCredential, completion: @escaping(User) -> Void) {
        
        Auth.auth().signIn(with: credentials) { _, error in
            if let error = error {
                print("DEBUG: Failed to sign user in: \(error.localizedDescription)")
            }
    
            guard let currentUser = Auth.auth().currentUser else { return }
            completion(currentUser)
        }
    }
    
    
    static func registerUser(withCredentials credentials: AuthCredential, firstName: String, lastName: String, completion: @escaping(Error?) -> Void) {
        
        Auth.auth().signIn(with: credentials) { result, error in
            
            if let error = error {
                print("DEBUG: Failed to register user: \(error.localizedDescription)")
            }
            
            guard let uid = result?.user.uid else { return }
            guard let email = result?.user.email else { return }
            
            let data: [String : Any] = ["uid"      : uid,
                                        "email"    : email,
                                        "firstName": firstName,
                                        "lastName" : lastName]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
        }
    }
    
    
    static func checkIfUserHasFirstLastName(_ uid: String, completion: @escaping(Bool) -> Void) {
        
        Firestore.firestore().collection("users").document(uid).getDocument { (snap, error) in
            var firstAndLastExists = true
            
            if snap?.get("firstName") == nil || snap?.get("lastName") == nil {
                firstAndLastExists = false
                completion(firstAndLastExists)
            } else {
                completion(firstAndLastExists)
            }
        }
    }
    
    
    static func checkIfAccountExists(_ credentials: AuthCredential, completion: @escaping(Bool) -> Void) {
        
        Auth.auth().signIn(with: credentials) { result, error in
            if let _ = error {
                print("DEBUG: Credential does not exist")
            }
            
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            
            Firestore.firestore().collection("users").document(currentUid).getDocument { (snap, error) in
                var accountExists = false
                
                if snap?.get("email") == nil {
                    accountExists = false
                    completion(accountExists)
                } else {
                    accountExists = true
                    completion(accountExists)
                }
            }
        }
    }
    
}
