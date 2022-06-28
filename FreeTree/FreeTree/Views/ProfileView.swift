//
//  ProfileView.swift
//  FreeTree
//
//  Created by Pedro Mota on 21/06/22.
//

import SwiftUI

struct ProfileView: View {
    @State var sheet = false
    var body: some View {
        Text("ProfileView")
            .onTapGesture {
                sheet = true
            }
            .sheetModal($sheet) {
                TreeProfileView(treeViewModel: TreeProfileViewModel(tree: Tree()),
                                comments: [Comment(),
                                           Comment(),
                                           Comment()])
            }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
