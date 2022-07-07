//
//  FirebaseCommentRepository.swift
//  FreeTree
//
//  Created by Pedro Mota on 05/07/22.
//

import Foundation

class FirebaseCommentRepository: CommentRepository {
    
    private let firebaseManager: FireBaseManager
    private let collection = "comment"
    
    init () {
        self.firebaseManager = FireBaseManager()
    }
    
    public func add(_ comment: Comment, completion: @escaping (Result<Comment, Error>) -> Void) {
        if nil != firebaseManager.addData(data: comment, collection: self.collection) {
            completion(.success(comment))
        } else {
            completion(.failure(FirebaseError.createError))
        }
    }
    
    public func fetchComments(for treeId: String, completion: @escaping (Result<[Comment], Error>) -> Void) {
        firebaseManager
            .getDocuments(with: "treeId", value: treeId, from: self.collection) { (result: Result<[Comment], FirebaseError>) in
                switch result {
                case .success(let comments): completion(.success(comments))
                case .failure(let failure): completion(.failure(failure))
                }
            }
    }
    
}
