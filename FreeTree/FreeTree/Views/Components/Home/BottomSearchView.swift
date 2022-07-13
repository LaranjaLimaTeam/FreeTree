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
    
    var animationTime = 0.25
    
    @Binding var isSearching: Bool
    
    @ObservedObject var mapViewModel: MapViewModel
    
    var trees: [Tree]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
            
            VStack(spacing: 0) {
                
                HStack {
                    
                    SearchBarView(searchText: $text, searching: $isSearching, searchAction: {
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
                        if filteredTrees.isEmpty {
                            isSearching = false
                        }
                    }, cleanData: {
                        self.text = ""
                        self.filteredTrees = []
                        hideKeyboard()
                    }, placeHolderText: "Write the tree you want")
                    RoundedImage(imageName: "person", backgroundColor: nil, systemName: true)
                        .frame(width: UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.width/10)
                    
                }.padding([.trailing, .top], 16)
                    .background(
                        Rectangle()
                            .cornerRadius(14, corners: [.topLeft, .topRight])
                            .foregroundColor(Color(UIColor.systemBackground))
                    )
                if !filteredTrees.isEmpty {
                    TreeList(
                        isSearching: $isSearching,
                        text: $text,
                        filteredTrees: $filteredTrees,
                        mapViewModel: mapViewModel
                    )
               }
                
            }
            
        }.frame(
            width: UIScreen.main.bounds.width ,
            height: isSearching ? (UIScreen.main.bounds.height/2 + UIScreen.main.bounds.height/10) : UIScreen.main.bounds.height/11,
            alignment: .top
        )
        .animation(
            Animation.easeInOut(duration: animationTime), value: isSearching
        )
    }
}

struct TreeList: View {
    
    @Binding var isSearching: Bool
    @Binding var text: String
    @Binding var filteredTrees: [Tree]
    
    @ObservedObject var mapViewModel: MapViewModel
    
    var body: some View {
        
        List(filteredTrees) { tree in
            SearchCell(tree: tree,
                       distance: mapViewModel.calculateDistance(tree: tree),
                       searchText: self.text)
            .onTapGesture {
                isSearching = false
                mapViewModel.selectedTree = tree
                mapViewModel.showTreeProfile = true
                self.text = ""
            }
        }
        .listStyle(.plain)
        .padding(.top, 8)
        .frame(width: UIScreen.main.bounds.width, height: isSearching ? UIScreen.main.bounds.height/2 : 0)
        .background(Color.white)
    }
}

struct BottomSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSearchView(
            isSearching: .constant(true),
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
