//
//  LoginFieldsView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 12/07/22.
//

import SwiftUI

struct LoginFieldsView: View {
    @Binding var email: String
    @Binding var password: String
    var body: some View {
        VStack(alignment: .trailing) {
            CustomTextField(
                text: $email,
                placeHolder: "E-mail"
            )
                .frame(width: UIScreen.main.bounds.width - 48)
            
            HybridTextField(
                text: $password,
                placeHolder: "Senha"
            )
            .frame(width: UIScreen.main.bounds.width - 48)
            Text("Esqueci Minha Senha")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.green)
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    let placeHolder: String
    var body: some View {
        VStack {
            TextField(placeHolder, text: $text)
            Divider()
        }
    }
}

struct HybridTextField: View {
    @Binding var text: String
    @State var isSecure = true
    let placeHolder: String
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                if isSecure {
                    SecureField(placeHolder, text: $text)
                } else {
                    TextField(placeHolder, text: $text)
                }
                Image(systemName: isSecure ? "eye.slash.circle.fill" : "eye.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 16)
                .onTapGesture {
                    isSecure.toggle()
                }
            }
            Divider()
        }
    }
}

struct LoginFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFieldsView(email: .constant(""),
                        password: .constant(""))
    }
}
