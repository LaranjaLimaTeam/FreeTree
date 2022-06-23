//
//  MapButton.swift
//  FreeTree
//
//  Created by Pedro Mota on 23/06/22.
//

import SwiftUI

struct MapButton: View {
    
    let systemIcon: String
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: self.systemIcon)
                .foregroundColor(Color.init(uiColor: .systemGreen))
                .frame(width: 30, height: 30)
                .padding(.all, 2)
        }
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton(systemIcon: "leaf") { }
    }
}
