//
//  Interest.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

enum CenterOfInterest: String, Equatable, CaseIterable, Codable {
    case cuisine = "Cuisine"
    case sport = "Sport"
    case couture = "Couture"
    case jardinage = "Jardinage"
    case arts = "Arts"
    case literature = "Littérature"
}

struct Interest: Identifiable, Codable {
    let id: String
    let category : CenterOfInterest
    let catImage : String
}


