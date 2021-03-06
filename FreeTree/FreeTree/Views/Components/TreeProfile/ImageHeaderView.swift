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
            RoundedImage(imageName: treeViewModel.tree.profile.imageName, backgroundColor: nil, systemName: true)
                .frame(width: UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.width/10)
            Text(treeViewModel.tree.profile.name)
                .font(.subheadline)
            Text("em \(treeViewModel.getStringDate(inputDate: treeViewModel.tree.creationTimeStamp))")
                .font(.subheadline)
        }
    }
}

struct RoundedImage: View {
    let imageName: String
    let backgroundColor: Color?
    let systemName: Bool
    var body: some View {
        if systemName {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(backgroundColor ?? .green)
                .clipShape(Circle())
        } else {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(backgroundColor ?? .green)
                .clipShape(Circle())
        }
        
    }
}
