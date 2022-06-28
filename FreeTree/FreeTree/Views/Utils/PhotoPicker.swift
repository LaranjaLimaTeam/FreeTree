//
//  PhotoPicker.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 28/06/22.
//

import UIKit
import SwiftUI

struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var images: [Image]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, images: $images)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?
    @Binding var images: [Image]
    init(isShown: Binding<Bool>, image: Binding<Image?>, images: Binding<[Image]>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
    _images = images
  }
  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     imageInCoordinator = Image(uiImage: unwrapImage)
      if let imageInCoordinator = imageInCoordinator {
          images.insert(imageInCoordinator, at: 0)
      }
     isCoordinatorShown = false
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}


