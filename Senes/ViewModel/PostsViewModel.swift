//
//  PostsViewModel.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = Bundle.main.decode([Post].self, from: "posts.json", dateDecodingStrategy: .iso8601)
    
    func addPost(_ post: Post) {
        posts.append(post)
    }

    func removePost(_ post: Post) {
        if let index = posts.firstIndex(of: post) {
            posts.remove(at: index)
        }
    }
    
    var postsSorted: [Post] {
        return posts.sorted {
            $0.datePost > $1.datePost
        }
    }
}
