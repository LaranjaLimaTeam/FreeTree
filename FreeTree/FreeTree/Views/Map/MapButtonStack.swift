//
//  MapButton.swift
//  FreeTree
//
//  Created by Pedro Mota on 23/06/22.
//

import SwiftUI

struct MapButtonStack: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            MapButton(systemIcon: "leaf") {
                withAnimation {
                    mapViewModel.showAddTreeModal()
                }
            }
            Divider()
            MapButton(systemIcon: "square.stack.3d.down.right") {
                // TODO: implementar ação
                print("change perspective button tapped")
            }
            Divider()
            MapButton(systemIcon: "paperplane") {
                mapViewModel.centralizeMapRegion()
            }
        }
        .frame(maxWidth: 30)
        .background(.white)
        .cornerRadius(10)
    }
}

struct MapButtonStack_Previews: PreviewProvider {
    static var previews: some View {
        MapButtonStack()
    }
}
