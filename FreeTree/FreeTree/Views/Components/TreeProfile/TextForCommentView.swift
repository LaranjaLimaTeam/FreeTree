//
//  TextForCommentView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct TextForCommentView: View {
    @State var text: String = ""
    @ObservedObject var treeViewModel: TreeProfileViewModel
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    var body: some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black)
            HStack {
                TextField("Digite seu comentário", text: $text)
                    .padding(.leading, 8)
                    .onTapGesture {
                        self.presentationMode = .large
                    }
                Button {
                    print("Clicou")
                    if let treeId = treeViewModel.tree.id {
                        let comment = Comment(treeId: treeId,
                                              user: UserProfile(),
                                              comment: self.text)
                        treeViewModel.insertComment(comment: comment)
                    }
                    self.text = ""
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(.green)
                        .padding(.trailing, 8)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width-32, height: 34)
        .padding(.horizontal, 16)
    }
}

struct TextForCommentView_Previews: PreviewProvider {
    static var previews: some View {
        TextForCommentView(treeViewModel: TreeProfileViewModel(tree: Tree()), presentationMode: .constant(.medium))
    }
}
