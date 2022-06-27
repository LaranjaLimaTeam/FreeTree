//
//  TextForCommentView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import SwiftUI

struct TextForCommentView: View {
    @State var text: String = ""
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    @ObservedObject var treeViewModel: TreeProfileViewModel
    var body: some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black)
            TextField("Digite seu comentário", text: $text)
                .padding(.leading, 8)
                .onTapGesture {
                    self.presentationMode = .large
                }
            Button {
                print("Clicou")
                let comment = Comment(user: UserProfile(), comment: text)
                treeViewModel.insertComment(comment: comment)
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundColor(.green)
                    .padding(.trailing, 8)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 34)
        .padding(.horizontal, 8)
    }
}

struct TextForCommentView_Previews: PreviewProvider {
    static var previews: some View {
        TextForCommentView(presentationMode: .constant(.medium), treeViewModel: TreeProfileViewModel(tree: Tree()))
    }
}
