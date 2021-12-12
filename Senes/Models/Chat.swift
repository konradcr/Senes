//
//  Chat.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

struct Chat: Identifiable, Codable {
    var id: String
    var messages: [Message]
    var hasUnreadMessage = false
    var person: Person
    
    init(id: String, messages: [Message]) {
        self.id = id
        self.messages = messages
        let users: [Person] = Bundle.main.decode([Person].self, from: "users.json")
        var userMatch = Person()
        
        if let match = users.first(where: {$0.id == id}) {
            userMatch = match
        }
        
        self.person = userMatch
    }
}
