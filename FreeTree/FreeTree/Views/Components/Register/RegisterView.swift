//
//  RegisterView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 12/07/22.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var registerViewModel = RegisterViewModel()
    let createAccount:(UserProfile?, Int) -> Void
    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                Text("Criar uma conta")
                    .font(.body)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.leading, 24)
            .padding(.top, 48)
            
            Spacer()
            
            CustomTextField(
                text: $registerViewModel.name ,
                placeHolder: "Insira um nome aqui"
            )
            .frame(width: UIScreen.main.bounds.width - 48)
            
            CustomTextField(
                text: $registerViewModel.email ,
                placeHolder: "Insira um e-mail aqui"
            )
            .frame(width: UIScreen.main.bounds.width - 48)
            
            CustomTextField(
                text: $registerViewModel.emailConfirmation,
                placeHolder: "Confirmar e-mail"
            )
            .frame(width: UIScreen.main.bounds.width - 48)
            
            HybridTextField(text: $registerViewModel.password,
                            placeHolder: "Insira a senha"
            )
            .frame(width: UIScreen.main.bounds.width - 48)
            
            HybridTextField(text: $registerViewModel.passwordConfirmation,
                            placeHolder: "Confirme a senha"
            )
            .frame(width: UIScreen.main.bounds.width - 48)
            
            Spacer()
            
            Button {
                print("Tentei Criar Conta")
                registerViewModel.tapCreateUser(completion: createAccount)
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.green)
                    Text("Criar conta")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 48,
                       height: 48)
                .padding(.bottom)
            }
        }
        .alert(isPresented: $registerViewModel.didFail) {
            Alert(title: Text("Erro ao criar conta"),
                  message: Text(registerViewModel.alertMessage),
                  dismissButton: .default(
                    Text("OK"),
                    action: {
                        self.registerViewModel.didFail = false
                        self.registerViewModel.alertMessage = ""
                    }
                  )
                  
            )
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(createAccount: { user, index in
            return
        })
    }
}
