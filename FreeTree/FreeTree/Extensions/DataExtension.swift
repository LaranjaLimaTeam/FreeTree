//
//  DataExtension.swift
//  FreeTree
//
//  Created by Pedro Mota on 11/07/22.
//

import Foundation
import SwiftUI

extension Data {
    func convertToImage() -> Image? {
        if let uiImage = UIImage(data: self) {
            let image = Image(uiImage: uiImage)
            return image
        }
        return nil
    }
}
