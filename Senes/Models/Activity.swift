//
//  Activity.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id: String = UUID().uuidString
    var title: String = ""
    var userID: String = ""
    var location: String = ""
    var datePost: Date = Date()
    var dateStartActivity: Date = Date()
    var dateEndActivity: Date = Date()
    var pictureActivity: String?
    var numberParticipants: Int = 10
    var description: String = ""
    var centerOfInterest: CenterOfInterest = .arts
    
    static func ==(lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
}
