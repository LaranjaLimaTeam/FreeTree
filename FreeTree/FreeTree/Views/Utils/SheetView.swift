//
//  SheetView.swift
//  sunset
//
//  Created by Pedro Mota on 24/03/22.
//
import Foundation
import SwiftUI
import UIKit

class HalfSheetController<Content>: UIHostingController<Content>,
                                        UISheetPresentationControllerDelegate where Content: View {
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier
    
    init(content: Content, presentationMode: Binding<UISheetPresentationController.Detent.Identifier>) {
        self._presentationMode = presentationMode
        super.init(rootView: content)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let presentation = sheetPresentationController {
            presentation.detents = [.medium(), .large()]
            presentation.prefersGrabberVisible = true
            presentation.largestUndimmedDetentIdentifier = .medium
            presentation.delegate = self
        }
    }
    
    func changeMode(mode: UISheetPresentationController.Detent.Identifier) {
        if let presentation = sheetPresentationController {
            presentation.selectedDetentIdentifier = mode
        }
    }
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if let newIdentifier = sheetPresentationController.selectedDetentIdentifier {
            self.presentationMode = newIdentifier
        }
    }
}

struct HalfSheet<Content>: UIViewControllerRepresentable where Content: View {
    
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier

    private let content: Content
    
    @inlinable init(@ViewBuilder content: () -> Content,
                    presentationMode: Binding<UISheetPresentationController.Detent.Identifier>) {
        self.content = content()
        self._presentationMode = presentationMode
    }
    
    func makeUIViewController(context: Context) -> HalfSheetController<Content> {
        return HalfSheetController(content: content, presentationMode: $presentationMode)
    }
    
    func updateUIViewController(_ controller: HalfSheetController<Content>, context: Context) {
        controller.changeMode(mode: presentationMode)
    }
}
