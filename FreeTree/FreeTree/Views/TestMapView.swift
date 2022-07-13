//
//  TestMapView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 13/07/22.
//

import SwiftUI

struct TestMapView: View {
    
    @ObservedObject var mapViewModel: MapViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            PolylineMapView()
                .edgesIgnoringSafeArea(.vertical)
                .onAppear {
                    mapViewModel.requestLocation()
                }
                .environmentObject(mapViewModel)
            Image("tree-placemark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            VStack {
                Spacer()
                HStack {
                    Button {
                        print("Cancelei arvore")
                        mapViewModel.currentCenterLocation = nil
                        mapViewModel.selectingPosition = false
                    } label: {
                        Text("Cancelar")
                    }
                    
                    Button {
                        print("To pegando localizaçao")
                        print(mapViewModel.currentCenterLocation)
                        mapViewModel.selectingPosition = false
                        mapViewModel.showAddTreeSheet.toggle()
                    } label: {
                        Text("Choose Spot")
                    }
                    
                }
            }
        }
        .onAppear {
            mapViewModel.cleanTreesOnMap()
            mapViewModel.selectingPosition = true
        }
    }
}

struct TestMapView_Previews: PreviewProvider {
    static var previews: some View {
        TestMapView(mapViewModel: MapViewModel() )
    }
}
