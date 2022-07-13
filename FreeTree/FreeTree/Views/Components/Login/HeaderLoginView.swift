//
//  HeaderLoginView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 12/07/22.
//

import SwiftUI

struct HeaderLoginView: View {
    var body: some View {
        VStack {
            Text("Olá, para continuar você precisa logar...")
                .font(.body)
                .foregroundColor(Color.init(uiColor: UIColor.lightGray))
            HStack {
                Image("FreeTreeLoginIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width/1.5)
            }
            .padding(.top, 48)
        }
    }
}

struct HeaderLoginView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderLoginView()
    }
}
