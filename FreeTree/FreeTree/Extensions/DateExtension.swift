//
//  Date.swift
//  FreeTree
//
//  Created by Pedro Mota on 06/07/22.
//

import Foundation

extension Date {
    static func from(_ timestamp: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let date = dateFormatter.date(from: timestamp)!
        return date
    }
    
    func toString() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateformat.string(from: self)
    }
}
