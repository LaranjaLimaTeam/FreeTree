//
//  PhotoList.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 28/06/22.
//

import SwiftUI

struct PhotoList: View {
    let images: [Data]
    let imageName = ["cloud",
                     "cloud",
                     "cloud",
                     "cloud"]
    
    let columns = [
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<imageName.count) { item in
                    if !images.isEmpty {
//                        if let uiImage = UIImage(data: item) {
//                            Image(uiImage: uiImage)
//                        }
                    } else {
                        Image(systemName: imageName[item])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxHeight: 300)
    }
}

struct PhotoList_Previews: PreviewProvider {
    static var previews: some View {
        PhotoList(images: [])
    }
}
