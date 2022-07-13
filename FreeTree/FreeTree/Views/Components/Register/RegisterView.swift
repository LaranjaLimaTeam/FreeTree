//
//  RegisterView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 12/07/22.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var registerViewModel = RegisterViewModel()
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
                registerViewModel.createUser()
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
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
