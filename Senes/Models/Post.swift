//
//  Post.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

struct Post: Identifiable, Codable, Equatable {
    var id: String = UUID().uuidString
    var datePost: Date = Date()
    var userID: String = UUID().uuidString
    var postImage: String?
    var description: String = ""
    
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
