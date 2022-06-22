//
//  ContentView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 15/06/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        let tabBarApperance = UITabBarAppearance()
        let tabBarItemApperance = UITabBarItemAppearance()
        tabBarItemApperance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
        tabBarItemApperance.selected.iconColor = .systemGreen
        tabBarApperance.stackedLayoutAppearance = tabBarItemApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
    }
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Mapa")
                }
            RecipesView()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Receitas")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
