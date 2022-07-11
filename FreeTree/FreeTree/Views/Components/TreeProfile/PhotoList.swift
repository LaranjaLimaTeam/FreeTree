//
//  PhotoList.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 28/06/22.
//

import SwiftUI

struct PhotoList: View {
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var pickingPhoto: Bool
    @ObservedObject var treeViewModel: TreeProfileViewModel
    
    let columns = [
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
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
                            self.pickingPhoto = true
                        }
                        ForEach(Array(treeViewModel.photos.enumerated()),  id: \.0) { (index, item) in
                            ZStack {
                                Color.white
                                    item
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
    }
}

struct PhotoList_Previews: PreviewProvider {
    static var previews: some View {
        PhotoList(
            pickingPhoto: .constant(false),
            treeViewModel: TreeProfileViewModel(tree: Tree())
        )
    }
}
