//
//  AddTreeForm.swift
//  FreeTree
//
//  Created by Pedro Mota on 12/07/22.
//

import SwiftUI

struct AddTreeForm: View {
    
    private var isPresented: Binding<Bool>
    private var isCapturingPhoto: Binding<Bool>
    @ObservedObject var addTreeViewModel: AddTreeViewModel
    
    init(_ isPresented: Binding<Bool>, _ isCapturingPhoto: Binding<Bool>, addTreeViewModel: AddTreeViewModel) {
        self.isPresented = isPresented
        self.isCapturingPhoto = isCapturingPhoto
        self.addTreeViewModel = addTreeViewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(
                "User name (email address)",
                text: $addTreeViewModel.tree.name
            )
            .padding(.horizontal, 16)
            .frame(height: 44)
            .background(.white)
            Section(title: "Imagens") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        CapturePhotoButton(isCapturingPhoto: self.isCapturingPhoto)
                        ForEach(Array(addTreeViewModel.photos.enumerated()), id: \.0) { _, image in
                            ImageView(for: image)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
            ToggleField("Foi plantada por você?", value: .constant(true))
            ToggleField("É frutífera?", value: .constant(true))
            Section(title: "Endereço") {
                Group {
                    Text(addTreeViewModel.tree.address.street)
                    Text(addTreeViewModel.tree.address.neighborHood)
                    Text("\(addTreeViewModel.tree.address.city) - \(addTreeViewModel.tree.address.stateOrProvince)" )
                    Text(addTreeViewModel.tree.address.zipCode)
                    //Text("Brasil")
                        .padding(.bottom, 12)
                }
            }
            .padding(.horizontal, 16)
            LargeButton(title: "Adicionar árvore") {
                withAnimation {
                    addTreeViewModel.addTree()
                    self.isPresented.wrappedValue.toggle()
                }
            }
            Spacer()
        }
        .padding(.top, 16)
        .frame(maxHeight: .infinity)
        .background(Color.init(uiColor: .systemGray5))
    }
}
