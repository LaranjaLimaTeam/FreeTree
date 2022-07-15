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
            MapButton(isSystemIcon: false, iconName: "leaf+add") {
                withAnimation {
                    mapViewModel.selectingPosition = true
                    mapViewModel.cleanTreesOnMap()
                    mapViewModel.updateSpan(zoom: 0.0025)
                    mapViewModel.centralizeMapRegion()
                }
            }
            Divider()

            MapButton(isSystemIcon: true, iconName: "paperplane") {
                mapViewModel.centralizeMapRegion()
            }
        }
        .frame(maxWidth: 40)
        .background(.white)
        .cornerRadius(10)
    }
}

struct MapButtonStack_Previews: PreviewProvider {
    static var previews: some View {
        MapButtonStack()
    }
}
