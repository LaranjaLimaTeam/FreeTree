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
                .frame(width: (UIScreen.main.bounds.width-32)/6, height: (UIScreen.main.bounds.width-32)/6)
                .padding([.top, .leading], 16)
            CommentTextView(comment: comment,
                        treeViewModel: treeViewModel)
            .padding(.vertical,16)
        }
        .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
        .background(.white)
        .cornerRadius(16)
    }
}

struct CommentView_Previews: PreviewProvider {
    static let comment = Comment(treeId: "alalla")
    static var previews: some View {
        CommentView(comment: comment,
                          treeViewModel: TreeProfileViewModel(tree: Tree()))
    }
}
