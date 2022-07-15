//
//  SegmentedControlView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 22/06/22.
//

import SwiftUI

struct SegmentedControlView: View {

    @Binding var showMode: Int
    let description: String
    let pagesName: [String]
    var body: some View {
        Picker(description, selection: $showMode) {
            ForEach(0..<pagesName.count) { pageIndex in
                Text(pagesName[pageIndex])
                    .tag(pageIndex)
            }
        }.pickerStyle(.segmented)
            .onAppear {
                UISegmentedControl.appearance().selectedSegmentTintColor = .systemGreen
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white],
                                                                       for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemGreen],
                                                                       for: .normal)
            }
    }
}

struct SegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlView(showMode: .constant(0),
                             description: "Choose your view",
                            pagesName: ["Dicas", "Etiquetas"])
            .previewLayout(.sizeThatFits)
            .padding()
        SegmentedControlView(showMode: .constant(1),
                             description: "Choose your view",
                             pagesName: ["Dicas", "Etiquetas"])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
