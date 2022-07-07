//
//  FirebaseManager.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 04/07/22.
//

import Foundation
import FirebaseFirestore

enum FirebaseError: Error {
    case fetchError
    case createError
}

struct FireBaseManager {
    
    private let dbCloud = Firestore.firestore()
    
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
}
