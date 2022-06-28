//
//  AddTreeView.swift
//  FreeTree
//
//  Created by Pedro Mota on 22/06/22.
//

import SwiftUI

struct AddTreeView: View {
    
    @ObservedObject var viewModel = AddTreeViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            TextField(
                "User name (email address)",
                text: $viewModel.tree.name
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
            ToggleField()
            ToggleField()
            LargeButton()
            Spacer()
        }
        .padding(.top, 16)
        .frame(maxHeight: .infinity)
        .background(Color.init(uiColor: .systemGray5))
    }
}

struct AddTreeView_Previews: PreviewProvider {
    static var previews: some View {
        AddTreeView()
    }
}

struct LargeButton: View {
    var body: some View {
        Button {
            print("")
        } label: {
            Text("Adicionar árvore")
                .foregroundColor(.white)
                .frame(maxWidth: .greatestFiniteMagnitude)
                .padding(.vertical, 13)
                .background(Color.init(uiColor: .systemGreen))
                .cornerRadius(13)
        }
        .padding(.horizontal, 16)
    }
}

struct ToggleField: View {
    var body: some View {
        HStack {
            Toggle("Foi plantada por você?", isOn: .constant(true))
                .padding(.horizontal, 16)
        }
        .frame(height: 44)
        .background(.white)
        .padding(.bottom, 8)
    }
}
