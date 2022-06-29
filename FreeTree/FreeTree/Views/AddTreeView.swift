//
//  AddTreeView.swift
//  FreeTree
//
//  Created by Pedro Mota on 22/06/22.
//

import SwiftUI

struct AddTreeView: View {
    
    @ObservedObject var viewModel = AddTreeViewModel()
    @Environment(\.dismiss) var dismiss
    
    private let title = "Adicionar árvore"

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Nome", text: $viewModel.tree.name)
                    } header: {
                        Text("identificação")
                    }
                    Section {
                        TextField("Rua", text: $viewModel.tree.address.street)
                        TextField("Número", value: $viewModel.tree.address.number, formatter: NumberFormatter())
                        TextField("Bairro", text: $viewModel.tree.address.neighborHood)
                        TextField("Cidade", text: $viewModel.tree.address.city)
                        TextField("Estado", text: $viewModel.tree.address.stateOrProvince)
                        TextField("CEP", text: $viewModel.tree.address.zipCode)
                    } header: {
                        Text("Endereço")
                    }
                    Section {
                        TextField("Latitude", value: $viewModel.tree.coordinates.latitude,
                                  format: FloatingPointFormatStyle())
                        TextField("Longitude", value: $viewModel.tree.coordinates.longitude,
                                  format: FloatingPointFormatStyle())
                    } header: {
                        Text("coordenadas")
                    }
                }
                Button {
                    viewModel.addTree()
                } label: {
                    Text("Adicionar árvore")
                        .foregroundColor(.white)
                        .frame(maxWidth: .greatestFiniteMagnitude)
                        .padding()
                        .background(Color.init(uiColor: .systemGreen))
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 40)
                }
            }
            .background(Color(uiColor: UIColor.systemGroupedBackground))
            .navigationTitle(self.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancelar") {
                        self.dismiss()
                    }
                }
            }
        }
        .tint(.init(uiColor: .systemGreen))
    }
}

struct AddTreeView_Previews: PreviewProvider {
    static var previews: some View {
        AddTreeView()
    }
}
