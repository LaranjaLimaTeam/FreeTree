//
//  TreeProfileView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct TreeProfileView: View {
    @State var pageControl = 0
    @ObservedObject var treeViewModel: TreeProfileViewModel
    @State var pickingPhoto = false
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    let sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: Image?
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
                    TipsView(treeViewModel: treeViewModel,
                             presentationMode: $presentationMode)
                    .padding(.top, 8)
                    .onAppear {
                        if treeViewModel.comments.isEmpty {
                            treeViewModel.fetchComment()
                        }
                    }
                case 1:
                    PhotoList(imageName: $treeViewModel.tree.images, pickingPhoto: $pickingPhoto)
                default:
                    EmptyView()
                }
            }
        } else {
            CaptureImageView(isShown: $pickingPhoto, image: $selectedImage, images: $treeViewModel.tree.images)
        }
    }
}

struct TreeProfileView_Previews: PreviewProvider {
    static let comments = [Comment(),
                           Comment(),
                           Comment()]
    static var previews: some View {
        TreeProfileView(treeViewModel: TreeProfileViewModel(tree: Tree()),
                        presentationMode: .constant(.medium))
    }
}
