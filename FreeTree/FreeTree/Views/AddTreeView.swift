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
            Section(title: "Imagens") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        CapturePhotoButton()
                        ImageView()
                        ImageView()
                        ImageView()
                        ImageView()
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
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

struct CapturePhotoButton: View {
    
    var body: some View {
        ZStack {
            Color.white
            Image(systemName: "camera")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.green)
                .frame(
                    width: (UIScreen.main.bounds.width - 4*16)/3,
                    height: (UIScreen.main.bounds.width - 4*16)/6
                )
        }
        .frame(
            width: (UIScreen.main.bounds.width - 4*16)/3,
            height: (UIScreen.main.bounds.width - 4*16)/3
        )
        .cornerRadius(16)
    }
    
}

// TODO: mover para arquivo separado
struct Section<Content: View>: View {
    
    var title: String
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .font(.headline)
                .padding(.bottom, 8)
            self.content
        }
    }
    
}

// TODO: mover para arquivo separado
struct AddTreeView_Previews: PreviewProvider {
    static var previews: some View {
        AddTreeView(
            isPresented: .constant(true)
        )
    }
}

// TODO: mover para arquivo separado
struct ImageView: View {
    var body: some View {
        ZStack {
            Color.white
            Image("tree2")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(
            width: (UIScreen.main.bounds.width - 4*16)/3,
            height: (UIScreen.main.bounds.width - 4*16)/3
        )
        .cornerRadius(16)
    }
}
