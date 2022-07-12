//
//  ImageView.swift
//  FreeTree
//
//  Created by Pedro Mota on 12/07/22.
//

import Foundation
import SwiftUI

struct ImageView: View {
    
    private var image: Image
    
    init(for image: Image) {
        self.image = image
    }
    
    var body: some View {
        ZStack {
            Color.white
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(
            width: (UIScreen.main.bounds.width - 4*16)/3,
            height: (UIScreen.main.bounds.width - 4*16)/3
        )
        .cornerRadius(16)
    }
}
