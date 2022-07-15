//
//  SwiftUIView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 14/07/22.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var shouldAnimate = false
    @State var leftOffset: CGFloat = -100
    @State var rightOffset: CGFloat = 100
    let label: String
    
    var body: some View {
        VStack {
            Text(label)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: 80, height: 20)
                .offset(x: shouldAnimate ? rightOffset : leftOffset)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                .onAppear {
                    self.shouldAnimate = true
                }
        }

    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(label: "Calculando a rota..")
    }
}
