//
//  TestMapView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 13/07/22.
//

import SwiftUI

struct TestMapView: View {
    
    @StateObject var mapViewModel = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .center) {
            PolylineMapView()
                .edgesIgnoringSafeArea(.top)
                .onAppear {
                    mapViewModel.requestLocation()
                }
                .environmentObject(mapViewModel)
            Image("tree-placemark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            VStack {
                Button {
                    print("To pegando localizaçao")
                    print(mapViewModel.currentCenterLocation)
                } label: {
                    Text("Get Location")
                }

                Spacer()
            }
        }
        .onAppear {
            mapViewModel.cleanTreesOnMap()
        }
    }
}

struct TestMapView_Previews: PreviewProvider {
    static var previews: some View {
        TestMapView()
    }
}
