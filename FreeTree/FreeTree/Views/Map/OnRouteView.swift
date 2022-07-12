//
//  OnRouteView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 11/07/22.
//

import SwiftUI

struct OnRouteView: View {
    var stopRoute: () -> Void
    var treeTitle:String
    @ObservedObject var routeViewModel: RouteViewModel
    
    var body:some View {
        VStack {
            HStack {
                Text("Indo para \(treeTitle)")
                    .font(.system(size: 24, weight: .semibold, design: .default))
                Spacer()
                Button {
                    self.stopRoute()
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .foregroundColor(.green)
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                }
            }.padding(.horizontal, 16)
            
            HStack {
                Text( String(format: "%.01f Km de distância",(routeViewModel.routeDistance ?? 0) / 1000) )
                Text("·")
                Image(systemName: "figure.walk")
                Text(String(format: "%.f minutos",
                            (routeViewModel.routeDistance ?? 0) * 0.0028))
                Spacer()
            }.padding([.bottom,.top], 8)
            .padding(.leading, 16)
        
        }
    }
}

struct OnRouteView_Previews: PreviewProvider {
    static var previews: some View {
        OnRouteView(stopRoute: {return},
                    treeTitle: "Limoeiro texto grande",
                    routeViewModel: RouteViewModel()
        )
    }
}


