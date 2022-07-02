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
    @Binding var images: [Image]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, images: $images)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: UIImage?
  @Binding var images: [Image]
    init(isShown: Binding<Bool>, image: Binding<UIImage?>, images: Binding<[Image]>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
    _images = images
  }
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
    let newUnwrapImage = rotateImage(image: unwrapImage)
    imageInCoordinator = newUnwrapImage
      if let imageInCoordinator = imageInCoordinator {
          images.insert(Image(uiImage: imageInCoordinator), at: 0)
      }
     isCoordinatorShown = false
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
    
    func rotateImage(image: UIImage) -> UIImage {
        if image.imageOrientation == UIImage.Orientation.up  {
            return image
        }
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        guard let copy = UIGraphicsGetImageFromCurrentImageContext() else { return image}
        UIGraphicsEndImageContext()
        return copy
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
