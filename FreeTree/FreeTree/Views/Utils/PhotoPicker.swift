//
//  PhotoPicker.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 28/06/22.
//

import UIKit
import SwiftUI

struct CaptureImageView {
    
    // MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    @Binding var images: [UIImage]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, images: $images)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: UIImage?
  @Binding var images: [UIImage]
    
    init(isShown: Binding<Bool>, image: Binding<UIImage?>, images: Binding<[UIImage]>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
    _images = images
  }
    
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      
      guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
      imageInCoordinator = unwrapImage
      images.insert(unwrapImage, at: 0)
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
