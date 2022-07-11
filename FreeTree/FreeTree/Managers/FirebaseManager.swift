//
//  FirebaseManager.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 04/07/22.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

enum FirebaseError: Error {
    case fetchError
    case createError
}

struct FireBaseManager {
    
    private let dbCloud = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    func getDocuments<T: Codable>(with key: String, value: String, from collection: String, completion: @escaping(Result<[T], FirebaseError>) -> Void) {
        var array: [T] = []
        let ref = dbCloud.collection(collection).whereField(key, isEqualTo: value).getDocuments() { querySnapshot, error in
            if let error = error {
                completion(.failure(.fetchError))
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    completion(.success([]))
                    return
                }
                
                array = documents.compactMap { queryDocumentSnapshot -> T? in
                    return try? queryDocumentSnapshot.data(as: T.self)
                }
                completion(.success(array))
            }
        }
    }
    
    func getData<T: Codable>(collection: String, completion: @escaping (Result<[T], FirebaseError>) -> Void) {
        var array: [T] = []
        let ref = dbCloud.collection(collection)
        ref.getDocuments { snapshot, error in
            if let err = error {
                print("Error getting documents. \(err.localizedDescription)")
                completion(.failure(.fetchError))
            } else {
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    completion(.success([]))
                    return
                }
                
                array = documents.compactMap { queryDocumentSnapshot -> T? in
                    return try? queryDocumentSnapshot.data(as: T.self)
                }
                completion(.success(array))
            }
        }
    }
    
    func addData<T: Codable>(data: T, collection: String) -> T? where T: Identifiable {
        let ref = dbCloud.collection(collection)
        do {
            if let dataId = data.id as? String {
                try ref.document(dataId).setData(from: data)
                return data
            }
        } catch let error {
            print("Error writing website to Firestore: \(error)")
        }
        return nil
    }
    
    func fetchAllFilesPath(from folder: String, completion: @escaping (Result<[String], FirebaseError>) -> Void) {
        let storageReference = storage.child(folder)
        
        var pathArray = [String]()
        storageReference.listAll { (result, error) in
            if let error = error {
                print("error while downloading files: \(error)")
                completion(.failure(.fetchError))
            }
            guard let result = result else {return}
            for item in result.items {
                // The items under storageReference.
                pathArray.append(item.fullPath)
            }
            completion(.success(pathArray))
        }
    }
    

    func downloadFile(from path: String, completion: @escaping (Result<Data, Error>) -> Void ) {
        let photoReference = storage.child(path)
        photoReference.getData(maxSize: 20*1024*1024) { data, err in
            if let error = err {
                print("Erro ao baixar arquivo")
                completion(.failure(FirebaseError.fetchError))
            } else {
                guard let safeData = data else { return }
                print("Baixei imagem")
                completion(.success(safeData))
            }
        }
    }
    
    func uploadFile(to path: String, data: Data, completion: @escaping (Result<Data,Error>) -> Void) {
        let storageRef = self.storage.child(path)
        storageRef.putData(data, metadata: nil){ (metadata, error) in
            guard let metaData = metadata else {
                print("encontramos um erro aqui")
                return
            }
            if let err = error {
                print("Erro ao salvar foto: \(err)")
            }
        }
    }
}
