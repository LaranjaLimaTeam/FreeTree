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
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    var body: some View {
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
                PhotoList()
            default:
                EmptyView()
            }
        }
    }
}

struct TreeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TreeProfileView(treeViewModel: TreeProfileViewModel(tree: Tree()),
                        presentationMode: .constant(.medium))
    }
}
