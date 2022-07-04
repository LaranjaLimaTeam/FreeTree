//
//  TipsView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct TipsView: View {
    @ObservedObject var treeViewModel: TreeProfileViewModel
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    
    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor.secondarySystemBackground)
            VStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 8) {
                        ForEach(treeViewModel.comments) { comment in
                            CommentView(comment: comment, treeViewModel: treeViewModel)
                        }
                    }
                }
                TextForCommentView(treeViewModel: treeViewModel, presentationMode: $presentationMode)
                .padding(.bottom, 8)
            }
            .padding(.top, 8)
        }
        
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView(treeViewModel: TreeProfileViewModel(tree: Tree()),
                 presentationMode: .constant(.medium))
    }
}
