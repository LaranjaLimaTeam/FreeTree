//
//  ImageExtension.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 07/07/22.
//
import UIKit

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func compress(to quality: UIImage.JPEGQuality) -> Data? {
        if let data = self.jpeg(quality) {
            return data
        } else {
            return nil
        }
    }

    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}
