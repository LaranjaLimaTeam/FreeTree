//
//  FireBaseManager.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 02/07/22.
//

import Foundation
import FirebaseFirestore

struct FireBaseManager {
    static let treesCollection = "trees"
    static let commentCollection = "comment"
    static let photoCollection = "photo"
    
    private let dbCloud = Firestore.firestore()
    
    func getData<T: Codable>(collection: String, completion: @escaping ([T]?) -> Void) {
        var array: [T]?
        let ref = dbCloud.collection(collection)
        ref.getDocuments { snapshot, error in
            if let err = error {
                print("Error getting documents. \(err.localizedDescription)")
                completion(nil)
            } else {
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    completion([])
                    return
                }
                
                array = documents.compactMap { queryDocumentSnapshot -> T? in
                    return try? queryDocumentSnapshot.data(as: T.self)
                }
                completion(array)
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
