//
//  MapButton.swift
//  FreeTree
//
//  Created by Pedro Mota on 23/06/22.
//

import SwiftUI

struct MapButton: View {
    
    let isSystemIcon: Bool
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            if isSystemIcon {
                Image(systemName: iconName)
                    .foregroundColor(Color.init(uiColor: .systemGreen))
                    .frame(width: 30, height: 30)
                    .padding(.all, 2)
            } else {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .padding(.all, 6)
            }

        }
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton(isSystemIcon: true, iconName: "leaf") {
        }
    }
}
