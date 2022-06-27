//
//  TipsView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct TipsView: View {
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    @ObservedObject var treeViewModel: TreeProfileViewModel
    let comments: [Comment]
    
    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor.secondarySystemBackground)
            VStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 8) {
                        ForEach(comments) { comment in
                            CommentHeaderView(comment: comment, treeViewModel: treeViewModel)
                        }
                    }
                }
                TextForCommentView(presentationMode: $presentationMode,
                               treeViewModel: treeViewModel)
                .padding(.bottom, 8)
            }
        }
        
    }
}

struct TipsView_Previews: PreviewProvider {
    static let comments = [Comment(),
                           Comment(),
                           Comment()]
    static var previews: some View {
        TipsView(presentationMode: .constant(.medium),
                 treeViewModel: TreeProfileViewModel(tree: Tree()),
                 comments: comments)
    }
}
