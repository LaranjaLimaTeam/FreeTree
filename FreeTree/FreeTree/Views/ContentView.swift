//
//  ContentView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 15/06/22.
//

import SwiftUI

struct ContentView: View {
    @State var viewIndex = 0
    @State var userProfile: UserProfile?
    
    var body: some View {
        switch viewIndex {
        case 0:
            LoginScreen(loginAction: { userData, index in
                self.userProfile = userData
                self.viewIndex = index
            },
                        createAccountAction: { value in
                self.viewIndex = value
            })
        case 1:
            RegisterView(createAccount: { user, index in
                self.userProfile = user
                self.viewIndex = index
            })
        default:
            MapView(userProfile: self.userProfile)
            
        }
        //MapView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
