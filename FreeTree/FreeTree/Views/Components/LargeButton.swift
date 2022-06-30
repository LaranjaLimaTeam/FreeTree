//
//  LargeButton.swift
//  FreeTree
//
//  Created by Pedro Mota on 30/06/22.
//

import SwiftUI

struct LargeButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Text(self.title)
                .foregroundColor(.white)
                .frame(maxWidth: .greatestFiniteMagnitude)
                .padding(.vertical, 13)
                .background(Color.init(uiColor: .systemGreen))
                .cornerRadius(13)
        }
        .padding(.horizontal, 16)
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeButton(title: "Adicionar árvore") { }
    }
}
