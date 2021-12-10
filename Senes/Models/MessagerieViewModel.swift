//
//  MessagerieViewModel.swift
//  TestJson
//
//  Created by Konrad Cureau on 10/12/2021.
//

import SwiftUI

class MessagerieViewModel: ObservableObject {
    
    @Published var chats = Chat.sampleChat
    
    func getSortedFilteredChats(query: String) -> [Chat] {
        let sortedChats = chats.sorted {
            guard let date1 = $0.messages.last?.sentTime else { return false }
            guard let date2 = $1.messages.last?.sentTime else { return false }
            return date1 > date2
        }
        if query == "" {
            return sortedChats
        }
        return sortedChats.filter { $0.person.name.lowercased().contains(query.lowercased()) }
    }
    
    
    func getSectionMessages(for chat: Chat) -> [[Message]] {
        
        var res = [[Message]]()
        var tmp = [Message]()
        for message in chat.messages {
            if let firstMessage = tmp.first {
                let daysBetween = firstMessage.sentTime.daysBetween(date: message.sentTime)
                if daysBetween >= 1 {
                    res.append(tmp)
                    tmp.removeAll()
                    tmp.append(message)
                } else {
                    tmp.append(message)
                }
            } else {
                tmp.append(message)
            }
        }
        res.append(tmp)
        return res
    }
    
    
    func markAsUnread(_ newValue: Bool, chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].hasUnreadMessage = newValue
            
        }
    }
    
    func sendMessage(_ text: String, in chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            let message = Message(text, type: .Sent)
            chats[index].messages.append(message)
            return message
        }
        return nil
    }
}
