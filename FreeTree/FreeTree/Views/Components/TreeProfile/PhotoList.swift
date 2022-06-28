//
//  PhotoList.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 28/06/22.
//

import SwiftUI

struct PhotoList: View {
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: Image?
    @State private var isImagePickerDisplay = false
    
    let images: [Data]
    @State var imageName = [Image("tree1"),
                            Image("tree2"),
                            Image("tree3")]
    
    let columns = [
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        if !isImagePickerDisplay {
            ScrollView {
//                NavigationLink(isActive: $isImagePickerDisplay) {
//                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
//                } label: {
//                    EmptyView()
//                }
                LazyVGrid(columns: columns, spacing: 16) {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            isImagePickerDisplay.toggle()
                        }
                    ForEach(0..<imageName.count) { item in
                        if !images.isEmpty {
    //                        if let uiImage = UIImage(data: item) {
    //                            Image(uiImage: uiImage)
    //                        }
                        } else {
                            imageName[item]
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(maxHeight: 300)
        } else {
            CaptureImageView(isShown: $isImagePickerDisplay, image: $selectedImage, images: $imageName)
        }
    }
}

struct PhotoList_Previews: PreviewProvider {
    static var previews: some View {
        PhotoList(images: [])
    }
}
