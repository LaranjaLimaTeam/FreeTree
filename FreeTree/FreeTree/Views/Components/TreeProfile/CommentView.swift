//
//  CommentView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 24/06/22.
//

import SwiftUI

struct CommentView: View {
    let comment: Comment
    let treeViewModel: TreeProfileViewModel
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            RoundedProfileImage(imageName: "person", backgroundColor: .blue)
                .padding([.top, .leading], 8)
                .frame(width: (UIScreen.main.bounds.width-32)/6, height: (UIScreen.main.bounds.width-32)/6)
            CommentTextView(comment: comment,
                        treeViewModel: treeViewModel)
        }
        .padding([.top, .horizontal])
        .background(.white)
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }
}

struct CommentView_Previews: PreviewProvider {
    static let comment = Comment(treeId: UUID().uuidString)
    static var previews: some View {
        CommentView(comment: comment,
                          treeViewModel: TreeProfileViewModel(tree: Tree()))
    }
}
