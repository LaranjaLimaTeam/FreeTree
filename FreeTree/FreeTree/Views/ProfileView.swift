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
                TreeHeaderView(tagLimit: 3, treeViewModel: TreeProfileViewModel(tree: Tree()))
            }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
