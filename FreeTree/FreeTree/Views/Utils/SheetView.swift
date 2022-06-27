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
                                     @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        return self.background(
            HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet)
        )
    }

}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {

    var sheetView: SheetView
    let viewController = UIViewController()

    @Binding var showSheet: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        self.viewController.view.backgroundColor = .clear
        return self.viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
    }

}

class CustomHostingController<Content: View>: UIHostingController<Content> {

    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
        }
    }

}
