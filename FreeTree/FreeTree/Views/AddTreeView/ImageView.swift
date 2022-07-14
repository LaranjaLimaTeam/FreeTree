//
//  ImageView.swift
//  FreeTree
//
//  Created by Pedro Mota on 12/07/22.
//

import Foundation
import SwiftUI

struct ImageView: View {
    
    private var image: UIImage
    
    init(for image: UIImage) {
        self.image = image
    }
    
    var body: some View {
        ZStack {
            Color.white
            Image(uiImage: image)
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
