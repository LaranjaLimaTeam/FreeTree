//
//  BottomSearchView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 11/07/22.
//

import SwiftUI

struct BottomSearchView: View {
    @State var text: String = ""
    @State var filteredTrees: [Tree] = []
    
    @Binding var isSearchig: Bool
    
    @ObservedObject var mapViewModel: MapViewModel
    
    var trees: [Tree]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SearchBarView(searchText: $text, searching: $isSearchig, searchAction: {
                    print("Busquei")
                    filteredTrees = trees.filter({ tree in
                        let lowerCasedText = text.lowercased()
                        for tag in tree.tags {
                            if tag.lowercased() == lowerCasedText {
                                return true
                            }
                        }
                        if tree.name.lowercased().contains(lowerCasedText) {
                            return true
                        }
                        return false
                    })
                }, cleanData: {
                    self.text = ""
                }, placeHolderText: "Write the tree you want")
                RoundedImage(imageName: "person", backgroundColor: nil, systemName: true)
                    .frame(width: UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.width/10)
            }.padding([.trailing, .top], 16)
                .background(
                    Rectangle()
                        .cornerRadius(14, corners: [.topLeft, .topRight])
                        .foregroundColor(Color(UIColor.systemBackground))
                )
            if isSearchig {
//                ScrollView {
//                    VStack(alignment: .leading) {
//                        ForEach(filteredTrees) { tree in
//                            SearchCell(tree: tree,
//                                       distance: mapViewModel.calculateDistance(tree: tree))
//                                .padding(.top, 8)
//                        }
//                    }
//                }
                    List(filteredTrees) { tree in
                        SearchCell(tree: tree,
                                   distance: mapViewModel.calculateDistance(tree: tree),
                                   searchText: self.text)
                        
                    }
                .listStyle(.plain)
                .padding(.top, 8)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
                .background(Color.white)
            }
        }
    }
}

struct BottomSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSearchView(
            isSearchig: .constant(true),
            mapViewModel: MapViewModel(),
            trees: []
        )
    }
}

struct SearchCell: View {
    let tree: Tree
    let distance: Double
    let searchText: String
    var body: some View {
        HStack {
            RoundedImage(imageName: "tree-placemark", backgroundColor: .gray, systemName: false)
                .frame(width: UIScreen.main.bounds.width/12, height: UIScreen.main.bounds.width/12)
            VStack(alignment: .leading) {
                Text(turnBold())
                    .font(.body)
                HStack {
                    Text("\(String(format: "%.1f", distance)) km,")
                        .font(.footnote)
                    Text(tree.address.street)
                        .font(.footnote)
                }
            }
        }
        .listRowBackground(Color.white)
    }
    
    func turnBold() -> AttributedString {
        var text = AttributedString(tree.name)
        if let rangeNegrito = AttributedString(tree.name.lowercased()).range(of: searchText.lowercased()) {
            let container = AttributeContainer().font(.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize))
            text[rangeNegrito].mergeAttributes(container)
            return text
        }
        return AttributedString(stringLiteral: tree.name)
    }
    
}
