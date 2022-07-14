//
//  FiltersView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 14/07/22.
//

import Foundation
import SwiftUI

struct FilterView: View {
    
    var body: some View {
        VStack {
            Button {
                print("Frutifera")
            } label: {
                HStack {
                   Text("Frutifera")
                }
            }.tint(.red)
                .frame(width: UIScreen.main.bounds.width, height: 46)
                .background(.white)
            Spacer()
                .frame( height: 20)
            Button {
                print("Click 1")
            } label: {
                Text("Limpar")
                    .padding(.leading, 16)
            }.tint(.red)
                .frame(width: UIScreen.main.bounds.width, height: 46, alignment: .leading)
                .background(.white)

        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.gray)
    }
}

struct FilterView_Previews: PreviewProvider {
    
    static var previews: some View {
        FilterView()
        
    }
    
}
