//
//  AddTreeView.swift
//  FreeTree
//
//  Created by Pedro Mota on 22/06/22.
//

import SwiftUI

struct AddTreeView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var addTreeViewModel = AddTreeViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(
                "User name (email address)",
                text: $addTreeViewModel.tree.name
            )
            .padding(.horizontal, 16)
            .frame(height: 44)
            .background(.white)
            Group {
                Text("Endereço")
                    .font(.headline)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                Text("Praça Henfil")
                Text("Cidade Universitária")
                Text("Campinas - SP")
                Text("13083")
                Text("Brasil")
                    .padding(.bottom, 12)
            }
            .padding(.horizontal, 16)
            ToggleField("Foi plantada por você?", value: .constant(true))
            ToggleField("É frutífera?", value: .constant(true))
            LargeButton(title: "Adicionar árvore") {
                withAnimation {
                    addTreeViewModel.addTree()
                    self.isPresented = false
                }
            }
            Spacer()
        }
        .padding(.top, 16)
        .frame(maxHeight: .infinity)
        .background(Color.init(uiColor: .systemGray5))
    }
}

struct AddTreeView_Previews: PreviewProvider {
    static var previews: some View {
        AddTreeView(
            isPresented: .constant(true)
        )
    }
}
