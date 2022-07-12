//
//  CapturePhotoButton.swift
//  FreeTree
//
//  Created by Pedro Mota on 12/07/22.
//

import SwiftUI

struct CapturePhotoButton: View {
    
    @Binding var isCapturingPhoto: Bool
    
    var body: some View {
        ZStack {
            Color.white
            Image(systemName: "camera")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.green)
                .frame(
                    width: (UIScreen.main.bounds.width - 4*16)/3,
                    height: (UIScreen.main.bounds.width - 4*16)/6
                )
        }
        .onTapGesture {
            isCapturingPhoto = true
        }
        .frame(
            width: (UIScreen.main.bounds.width - 4*16)/3,
            height: (UIScreen.main.bounds.width - 4*16)/3
        )
        .cornerRadius(16)
    }
    
}
