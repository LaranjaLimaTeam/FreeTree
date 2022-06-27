//
//  SheetView.swift
//  sunset
//
//  Created by Pedro Mota on 24/03/22.
//
import Foundation
import SwiftUI
import UIKit

extension View {

    func sheetModal<SheetView: View>(_ showSheet: Binding<Bool>,
                                     _ presentationMode: Binding<UISheetPresentationController.Detent.Identifier>, 
                                     @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        let sheetView = sheetView()
        return self.background(
            HalfSheetHelper(sheetView: sheetView,
                            customHostingController: CustomHostingController(rootView: sheetView),
                            showSheet: showSheet,
                            presentationMode: presentationMode)
        )
    }

}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {

    var sheetView: SheetView
    let viewController = UIViewController()
    let customHostingController: CustomHostingController<SheetView>

    @Binding var showSheet: Bool
    @Binding var presentationMode: UISheetPresentationController.Detent.Identifier

    func makeUIViewController(context: Context) -> UIViewController {
        self.viewController.view.backgroundColor = .clear
        return self.viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        print("update! \(presentationMode)")
        if showSheet {
            customHostingController.changeDetentMode(mode: presentationMode)
            uiViewController.present(customHostingController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
        customHostingController.changeDetentMode(mode: presentationMode)
    }

}

class CustomHostingController<Content: View>: UIHostingController<Content> {

    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
        }
    }
    
    func changeDetentMode(mode: UISheetPresentationController.Detent.Identifier) {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.selectedDetentIdentifier = mode
        }
    }

}
