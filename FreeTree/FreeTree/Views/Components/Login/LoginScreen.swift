//
//  LoginScreen.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 12/07/22.
//

import SwiftUI

struct LoginScreen: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        VStack {
            HeaderLoginView()
                .padding(.top, 48)
            Spacer()
            LoginFieldsView(email: $email,
                            password: $password)
            Spacer()
            LoginButtons(loginAction: {return}, createAccountAction: {return})
                .padding(.bottom, 24)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
