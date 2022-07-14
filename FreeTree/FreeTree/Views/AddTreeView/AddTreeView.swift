//
//  AddTreeView.swift
//  FreeTree
//
//  Created by Pedro Mota on 22/06/22.
//

import SwiftUI

struct AddTreeView: View {
    
    @State var isCapturingPhoto: Bool = false
    @State var capturedImage: UIImage? = nil
    @Binding var isPresented: Bool
    @ObservedObject var addTreeViewModel = AddTreeViewModel()
    
    var body: some View {
        if isCapturingPhoto {
            CaptureImageView(
                isShown: $isCapturingPhoto,
                image: $capturedImage,
                images: $addTreeViewModel.photos
            )
        } else {
            AddTreeForm(
                $isPresented,
                $isCapturingPhoto,
                addTreeViewModel: addTreeViewModel
            )
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct AddTreeView_Previews: PreviewProvider {
    static var previews: some View {
        AddTreeView(
            isPresented: .constant(true)
        )
    }
}
