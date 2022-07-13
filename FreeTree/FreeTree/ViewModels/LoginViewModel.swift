//
//  LoginViewModel.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 12/07/22.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var didSucceedLogin: Bool?
    @Published var user: UserProfile?
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                print("Falha ao logar")
                return
            }
            if let safeAuthResult = authResult {
                let user = safeAuthResult.user
                let email = user.email
            }
        }
    }
}


class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailConfirmation: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var didSucceedCreatingUser: Bool?
    
    func createUser() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("User signs up successfully")
                let newUser = UserProfile(name: self.name, email: self.email)
                
            }
        }
    }
    
    func sendUserToDB(user: UserProfile) {
        
    }
}
