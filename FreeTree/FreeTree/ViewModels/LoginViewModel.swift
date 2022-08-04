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
    @Published var didFailLogin: Bool = false
    
    private let firebaseManager: FireBaseManager =  FireBaseManager()
    private let collection = "users"
    
    func login(completion: @escaping (UserProfile?, Int) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                print("Falha ao logar")
                self?.didFailLogin = true
                completion(self?.user, 0)
                return
            }
            if let safeAuthResult = authResult {
                strongSelf.getUser(id: safeAuthResult.user.uid, completion: completion)
                
            }
        }
    }
    
    func getUser(id: String, completion: @escaping (UserProfile?, Int) -> Void) {
        firebaseManager.getData(collection: self.collection) { (result: Result<[UserProfile],FirebaseError>) in
            switch result {
            case .success(let userProfile):
                self.user = userProfile.filter({ item in
                    item.userID == id
                }).first!
                completion(self.user, 3)
            case .failure(let error):
                break
            }
        }
    }
    
    func didTapLoginButton(completion: @escaping (UserProfile?, Int) -> Void) {
        if !email.isEmpty && !password.isEmpty {
            self.login(completion: completion)
        }
    }
}


class RegisterViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailConfirmation: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var didSucceedCreatingUser: Bool = false
    @Published var didFail: Bool = false
    private let firebaseManager: FireBaseManager =  FireBaseManager()
    private let collection = "users"
    var alertMessage = ""
    
    func createUser(completion: @escaping (UserProfile?, Int) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                if let safeAuthResult = authResult {
                    print("User signs up successfully")
                    let newUser = UserProfile(userID: safeAuthResult.user.uid, name: self.name)
                    self.sendUserToDB(user: newUser)
                    self.didSucceedCreatingUser = true
                    completion(newUser, 2)
                }
            }
        }
    }
    
    func verifyPassword() -> Bool {
        return (password == passwordConfirmation) && !password.isEmpty
    }
    
    func verifyEmail() -> Bool {
        return (email == emailConfirmation) && !email.isEmpty
    }
    
    func tapCreateUser(completion: @escaping (UserProfile?, Int) -> Void) {
        let validPassword = verifyPassword()
        let validEmail = verifyEmail()
        if name.isEmpty {
            self.didFail = true
            alertMessage = "Por favor preencha o nome"
            return
        }
        
        if !validEmail {
            self.didFail = true
            alertMessage = "Por favor verificar o campo de email"
            return
        }
        
        if !validPassword {
            self.didFail = true
            alertMessage = "Por favor verificar as senhas"
            return
        }
        
        self.createUser(completion: completion)
    }
    
    func sendUserToDB(user: UserProfile) {
        let _ = firebaseManager.addData(data: user, collection: self.collection)
    }
}
