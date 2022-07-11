//
//  CommentRepository.swift
//  FreeTree
//
//  Created by Pedro Mota on 05/07/22.
//

import Foundation

protocol CommentRepository {
    func fetchComments(for treeId: String, completion: @escaping (Result<[Comment], Error>) -> Void)
    func add(_ comment: Comment, completion: @escaping (Result<Comment, Error>) -> Void)
}
