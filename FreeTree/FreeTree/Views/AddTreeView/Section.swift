//
//  Section.swift
//  FreeTree
//
//  Created by Pedro Mota on 12/07/22.
//

import SwiftUI

struct Section<Content: View>: View {
    
    var title: String
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .font(.headline)
                .padding(.bottom, 8)
            self.content
        }
    }
}
