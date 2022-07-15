//
//  ToggleField.swift
//  FreeTree
//
//  Created by Pedro Mota on 30/06/22.
//

import SwiftUI

struct ToggleField: View {
    
    var title: String
    var value: Binding<Bool>
    
    init(_ title: String, value: Binding<Bool>) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        HStack {
            Toggle(self.title, isOn: self.value)
                .padding(.horizontal, 16)
        }
        .frame(height: 44)
        .background(.white)
        .padding(.bottom, 8)
    }
}

struct ToggleField_Previews: PreviewProvider {
    static var previews: some View {
        ToggleField("Toggle field", value: .constant(true))
    }
}
