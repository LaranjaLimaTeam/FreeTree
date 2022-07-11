//
//  PhotoRepository.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 07/07/22.
//

import Foundation
import UIKit

protocol PhotoRepository {
    func fetchPhotos(for treeId: String, completion: @escaping (Result<Data, Error>) -> Void)
    func add(_ treeId: String, _ photo: Data, completion: @escaping (Result<Data, Error>) -> Void)
}
