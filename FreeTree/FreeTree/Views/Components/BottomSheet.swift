//
//  SwiftUIView.swift
//  FreeTree
//
//  Created by Pedro Mota on 27/06/22.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    
    @Binding var isPresented: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        GeometryReader { reader in
            content
                .cornerRadius(10)
                .offset(y: isPresented ? reader.frame(in: .global).height/1.75 : reader.frame(in: .global).height)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(isPresented: .constant(true)) {
            Text("Hello World")
        }
    }
}
