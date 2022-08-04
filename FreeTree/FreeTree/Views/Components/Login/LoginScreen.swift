//
//  LoginScreen.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 12/07/22.
//

import SwiftUI

struct LoginScreen: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    let loginAction: (UserProfile?,Int) -> Void
    let createAccountAction: (Int) -> Void
    
    var body: some View {
        VStack {
            HeaderLoginView()
                .padding(.top, 48)
            Spacer()
            LoginFieldsView(email: $loginViewModel.email,
                            password: $loginViewModel.password)
            Spacer()
            LoginButtons(loginAction: {
                self.loginViewModel.didTapLoginButton(completion: loginAction)
            },
                         createAccountAction: {
                print("Cliquei")
                createAccountAction(1)
                
            })
                .padding(.bottom, 24)
        }
        .alert(isPresented: $loginViewModel.didFailLogin) {
            Alert(title: Text("Erro ao entrar"),
                  message: Text("Erro, por favor verificar email e senha"),
                  dismissButton: .default(
                    Text("OK"),
                    action: {
                        self.loginViewModel.didFailLogin = false
                    }
                  )
                  
            )
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(loginAction: {user,index  in
            return
        }, createAccountAction: { value in
            print(value)
            return
        })
    }
}
