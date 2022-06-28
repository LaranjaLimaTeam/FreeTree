//
//  TreeProfileView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct TreeProfileView: View {
    @State var pageControl = 0
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    @ObservedObject var treeViewModel: TreeProfileViewModel
    let comments: [Comment]
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
                TipsView(presentationMode: $presentationMode,
                         treeViewModel: treeViewModel,
                         comments: comments)
                .padding(.top, 8)
            case 1:
                Text("Nao Implementado Ainda")
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
        TreeProfileView(presentationMode: .constant(.medium), treeViewModel: TreeProfileViewModel(tree: Tree()),
                        comments: comments)
    }
}
