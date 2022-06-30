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
                    LazyVGrid(columns: columns, spacing: 16) {
                        ZStack {
                            Color.white
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.green)
                                .frame(width: (UIScreen.main.bounds.width - 4*16)/3,
                                       height: (UIScreen.main.bounds.width - 4*16)/6)
                        }
                        .frame(width: (UIScreen.main.bounds.width - 4*16)/3,
                                height: (UIScreen.main.bounds.width - 4*16)/3)
                        .cornerRadius(16)
                            .onTapGesture {
                                isImagePickerDisplay.toggle()
                            }
                        ForEach(0..<imageName.count) { item in
                            ZStack {
                                Color.white
                                imageName[item]
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: (UIScreen.main.bounds.width - 4*16)/3,
                                           height: (UIScreen.main.bounds.width - 4*16)/3)
                            }
                            .frame(width: (UIScreen.main.bounds.width - 4*16)/3,
                                    height: (UIScreen.main.bounds.width - 4*16)/3)
                            .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
            }
            .background(Color.init(uiColor: UIColor.secondarySystemBackground))
        } else {
            CaptureImageView(isShown: $isImagePickerDisplay, image: $selectedImage, images: $imageName)
        }
    }
}

struct PhotoList_Previews: PreviewProvider {
    static var previews: some View {
        PhotoList()
    }
}
