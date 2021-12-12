//
//  Message.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

struct Message: Identifiable, Codable {

    enum MessageType: String, Codable {
        case Sent = "Sent"
        case Received = "Received"
    }

    var id = UUID()
    let sentTime: Date
    let text: String
    let type: MessageType

    init(_ text: String, type: MessageType, date: Date) {
        self.sentTime = date
        self.type = type
        self.text = text
    }

    init(_ text: String, type: MessageType) {
        self.init(text, type: type, date: Date())
    }
}
