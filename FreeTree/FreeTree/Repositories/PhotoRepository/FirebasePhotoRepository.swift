//
//  FirebasePhotoRepository.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 07/07/22.
//

import Foundation

class FirebasePhotoRepository: PhotoRepository {
        
    private let firebaseManager: FireBaseManager
    private let storageList = "images"
    
    init () {
        self.firebaseManager = FireBaseManager()
    }
    
    func fetchPhotos(for treeId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let completePath = "\(self.storageList)/\(treeId)"
        var filesPath: [String] = []
        self.firebaseManager.fetchAllFilesPath(from: completePath) { (result: Result<[String], FirebaseError>) in
            switch result {
            case .success(let paths):
                for path in paths {
                    print("Downloading \(path)")
                    self.firebaseManager.downloadFile(from: path) { (result: Result<Data, Error>) in
                        switch result {
                        case .success(let imageData):
                            print("Veio \(path)")
                            completion(.success(imageData))
                        case .failure(let error):
                            print("Erro ao baixar imagem")
                        }
                    }
                }
            case .failure(let error):
                print("Falhou")
            }
        }
    }
    
    func add(_ treeId:String, _ photo: Data, completion: @escaping (Result<Data, Error>) -> Void) {
        let id = UUID().uuidString
        let path = "\(self.storageList)/\(treeId)/\(id).png"
        self.firebaseManager.uploadFile(to: path, data: photo) { (result:Result<Data, Error>) in
            completion(result)
        }
    }
}
