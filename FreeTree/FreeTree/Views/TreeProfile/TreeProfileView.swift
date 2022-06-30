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
    let comments: [Comment]
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
                TipsView(treeViewModel: treeViewModel,
                         comments: comments,
                         presentationMode: $presentationMode)
                .padding(.top, 8)
            case 1:
                PhotoList()
            default:
                EmptyView()
            }
        }
    }
}

struct TreeProfileView_Previews: PreviewProvider {
    static let comments = [Comment(),
                           Comment(),
                           Comment()]
    static var previews: some View {
        TreeProfileView(treeViewModel: TreeProfileViewModel(tree: Tree()),
                        comments: comments, presentationMode: .constant(.medium))
    }
}
