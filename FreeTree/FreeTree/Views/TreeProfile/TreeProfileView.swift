//
//  TreeProfileView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct TreeProfileView: View {
    
    @State var pageControl = 0
    @State var pickingPhoto = false
    @State private var selectedImage: UIImage?
    
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    
    @ObservedObject var treeViewModel: TreeProfileViewModel
    
    let sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        if !pickingPhoto {
            VStack {
                TreeHeaderView(tagLimit: 3,
                               treeViewModel: treeViewModel)
                SegmentedControlView(showMode: $pageControl,
                                     description: "Choose the view you want",
                                     pagesName: ["Dicas", "Fotos"])
                .padding(.horizontal, 16)
                switch pageControl {
                case 0:
                    TipsView(
                        treeViewModel: treeViewModel,
                        presentationMode: $presentationMode
                    )
                    .padding(.top, 8)
                    .onAppear {
                        self.treeViewModel.fetchComments()
                    }
                case 1:
                    PhotoList(pickingPhoto: $pickingPhoto, treeViewModel: treeViewModel)
                default:
                    EmptyView()
                }
            }
            .onAppear {
                treeViewModel.fetchPhotos()
            }
        } else {
            CaptureImageView(isShown: $pickingPhoto, image: $selectedImage, images: $treeViewModel.photos)
                .onAppear {
                    self.presentationMode = .large
                }
                .onDisappear {
                    print("Sai da tela")
                }
        }
    }
}

struct TreeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TreeProfileView(
            presentationMode: .constant(.medium),
            treeViewModel: TreeProfileViewModel(tree: Tree())
        )
    }
}
