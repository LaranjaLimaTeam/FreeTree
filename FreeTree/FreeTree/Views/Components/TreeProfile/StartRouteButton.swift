//
//  StartRouteButton.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 11/07/22.
//

import Foundation
import SwiftUI

struct StartRouteButton: View {
    
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.white)
                Text("Ir")
                    .foregroundColor(.white)
            }
            .padding(4)
            .background(.green)
            .cornerRadius(10)
        }
        .padding([.trailing, .top], 16)
    }
}
