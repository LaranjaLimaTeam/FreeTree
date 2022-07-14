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
            Spacer()
            TextField(
                "Nome da árvore",
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
            ToggleField("Foi plantada por você?", value: $addTreeViewModel.tree.wasPlantedByUser)
            ToggleField("É frutífera?", value: $addTreeViewModel.tree.isFruitful)
            Section(title: "Endereço") {
                Group {
                    Text("Praça Henfil")
                    Text("Cidade Universitária")
                    Text("Campinas - SP")
                    Text("13083")
                    Text("Brasil")
                        .padding(.bottom, 12)
                }
            }
            .padding(.horizontal, 16)
            Spacer()
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
        .ignoresSafeArea(.keyboard)
    }
}
