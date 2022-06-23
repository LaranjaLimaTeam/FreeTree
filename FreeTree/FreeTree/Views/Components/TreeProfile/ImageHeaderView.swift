//
//  ImageHeaderView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 23/06/22.
//

import SwiftUI

struct ImageHeader: View {
    @ObservedObject var treeViewModel: TreeProfileViewModel
    var body: some View {
        HStack {
            Text("Criado por")
                .font(.subheadline)
            Image(systemName: treeViewModel.tree.profile.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(.green)
                .clipShape(Circle())
                .frame(width: UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.width/10)
            Text(treeViewModel.tree.profile.name)
                .font(.subheadline)
            Text("em \(treeViewModel.getStringDate())")
                .font(.subheadline)
        }
    }
}
