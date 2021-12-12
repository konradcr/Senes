//
//  Person.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

class Person: Identifiable, Hashable, Equatable, ObservableObject, Codable {
    @Published var id: String = UUID().uuidString
    @Published var name: String = ""
    @Published var city: String = ""
    @Published var description: String = ""
    @Published var profilPic : String = ""
    @Published var centersOfInterest: [CenterOfInterest] = []
    @Published var isCertified: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(city)
        hasher.combine(description)
        hasher.combine(centersOfInterest)
        hasher.combine(isCertified)
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.city == rhs.city && lhs.description == rhs.description && lhs.centersOfInterest == rhs.centersOfInterest && lhs.isCertified == rhs.isCertified && lhs.profilPic == rhs.profilPic
    }
    
    enum CodingKeys: CodingKey {
        case id, name, city, description, profilPic, centersOfInterest, isCertified
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        try container.encode(city, forKey: .city)
        try container.encode(description, forKey: .description)
        
        try container.encode(name, forKey: .name)
        try container.encode(profilPic, forKey: .profilPic)
        try container.encode(centersOfInterest, forKey: .centersOfInterest)
        try container.encode(isCertified, forKey: .isCertified)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        city = try container.decode(String.self, forKey: .city)
        description = try container.decode(String.self, forKey: .description)
        profilPic = try container.decode(String.self, forKey: .profilPic)
        
        centersOfInterest = try container.decode([CenterOfInterest].self, forKey: .centersOfInterest)
        isCertified = try container.decode(Bool.self, forKey: .isCertified)
    }
    
    init() {}
}
