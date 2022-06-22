//
//  AddTreeView.swift
//  FreeTree
//
//  Created by Pedro Mota on 22/06/22.
//

import SwiftUI

struct AddTreeView: View {
    
    @State var tree = Tree()
    
    private let title = "Adicionar árvore"
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Nome", text: $tree.name)
                    } header: {
                        Text("identificação")
                    }
                    Section {
                        TextField("Rua", text: $tree.address.street)
                        TextField("Número", value: $tree.address.number, formatter: NumberFormatter())
                        TextField("Bairro", text: $tree.address.neighborHood)
                        TextField("Cidade", text: $tree.address.city)
                        TextField("Estado", text: $tree.address.stateOrProvince)
                        TextField("CEP", text: $tree.address.zipCode)
                    } header: {
                        Text("Endereço")
                    }
                    Section {
                        TextField("Latitude", value: $tree.coordinates.latitude, format: FloatingPointFormatStyle())
                        TextField("Longitude", value: $tree.coordinates.longitude, format: FloatingPointFormatStyle())
                    } header: {
                        Text("coordenadas")
                    }
                }
                Button {
                    {}()
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
                        print("dismiss")
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
