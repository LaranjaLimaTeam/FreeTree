//
//  CommentTextView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct CommentTextView: View {
    let comment: Comment
    let treeViewModel: TreeProfileViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(comment.user.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("·")
                Text(treeViewModel.getStringDate(inputDate: comment.date))
                    .font(.footnote)
            }
            Text(comment.comment)
                .font(.footnote)
        }
    }
}
struct CommentTextView_Previews: PreviewProvider {
    static let comment = Comment()
    static var previews: some View {
        CommentTextView(comment: comment, treeViewModel: TreeProfileViewModel(tree: Tree()))
    }
}
