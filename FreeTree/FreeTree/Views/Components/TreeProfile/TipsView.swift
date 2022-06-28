//
//  TipsView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct TipsView: View {
    @ObservedObject var treeViewModel: TreeProfileViewModel
    let comments: [Comment]
    
    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor.secondarySystemBackground)
            VStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 8) {
                        ForEach(comments) { comment in
                            CommentView(comment: comment, treeViewModel: treeViewModel)
                        }
                    }
                }
                TextForCommentView(treeViewModel: treeViewModel)
                .padding(.bottom, 8)
            }
            .padding(.top, 8)
        }
        
    }
}

struct TipsView_Previews: PreviewProvider {
    static let comments = [Comment(),
                           Comment(),
                           Comment()]
    static var previews: some View {
        TipsView(treeViewModel: TreeProfileViewModel(tree: Tree()),
                 comments: comments)
    }
}
