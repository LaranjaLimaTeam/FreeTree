//
//  LoginButtons.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 12/07/22.
//

import SwiftUI

struct LoginButtons: View {
    var loginAction: () -> Void
    var createAccountAction: () -> Void
    var body: some View {
        VStack {
            Button {
                print("Tentei Login")
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.green)
                    Text("Entrar")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 48,
                       height: 48)
            }
            Text("Criar uma conta")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.green)
        }
    }
}

struct LoginButtons_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtons(loginAction: {return}, createAccountAction: {return})
    }
}
