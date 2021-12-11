//
//  Model.swift
//  TestJson
//
//  Created by Konrad Cureau on 10/12/2021.
//

import SwiftUI

enum CenterOfInterest: String, Equatable, CaseIterable, Codable {
    case cuisine = "Cuisine"
    case sport = "Sport"
    case couture = "Couture"
    case jardinage = "Jardinage"
    case arts = "Arts"
    case literature = "Littérature"
}

class CurrentUser: Person {
    @Published var friends: [Person] = []
    @Published var activities: [Activity] = []
    @Published var chats: [Chat] = []
    @Published var myPost: [Post] = []
    
    var activitiesSorted: [Activity] {
        return activities.sorted {
            $0.dateStartActivity > $1.dateStartActivity
        }
    }
    
    var friendsSorted: [Person] {
        return friends.sorted {
            $0.name < $1.name
        }
    }
    
    func getFriendsInscription() -> [Person] {
        let users: [Person] = Bundle.main.decode([Person].self, from: "users.json")
        
        let friends = users.filter { $0.isYourFriend == true }
        return friends.sorted {
            $0.name < $1.name
        }
    }
    
    func addFriend(user: Person) {
        friends.append(user)
    }
    
    func removeFriend(user: Person) {
        if let index = friends.firstIndex(of: user) {
            friends.remove(at: index)
        }
    }
    
    func getActivities() -> [Activity] {
        let activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)
        return activities.filter { $0.participating == true }
    }
}

class Person: Identifiable, Hashable, Equatable, ObservableObject, Codable {
    @Published var id: String = "c24af5af-8fc0-4f9d-bb8f-1a329bd16220"
    @Published var name: String = "Germaine"
    @Published var city: String = "Lyon"
    @Published var description: String = "Passionnée d'art et de culture j'adore echanger et rencontrer de nouvelles personnnes. N'hésites pas à m'ajouter en amis pour que l'on puisse discuter à propos de nos centres d'intérêts en commun !"
    @Published var profilPic : String = "Germaine"
    @Published var centersOfInterest: [CenterOfInterest] = [.arts,.jardinage]
    @Published var isCertified: Bool = false
    @Published var isYourFriend: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(city)
        hasher.combine(description)
        hasher.combine(centersOfInterest)
        hasher.combine(isCertified)
        hasher.combine(isYourFriend)
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.city == rhs.city && lhs.description == rhs.description && lhs.centersOfInterest == rhs.centersOfInterest && lhs.isCertified == rhs.isCertified && lhs.profilPic == rhs.profilPic && lhs.isYourFriend == rhs.isYourFriend
    }
    
    enum CodingKeys: CodingKey {
        case id, name, city, description, profilPic, centersOfInterest, isCertified, isYourFriend
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
        try container.encode(isYourFriend, forKey: .isYourFriend)
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
        isYourFriend = try container.decode(Bool.self, forKey: .isYourFriend)
    }
    
    init() {}
}


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

struct Activity: Identifiable, Codable {
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
    var participating : Bool = false
}

struct Post: Identifiable, Codable  {
    var id: String = UUID().uuidString
    var datePost: Date = Date()
    var userID: String = UUID().uuidString
    var postImage: String?
    var description: String = ""
}

struct LoaderPicture {
    var isImagePickerShown : Bool = false
    var inputImage: UIImage?
    var sourceType = UIImagePickerController.SourceType.photoLibrary
    var image: Image?
}

struct Interest: Identifiable, Codable {
    let id: String
    let category : CenterOfInterest
    let catImage : String
}
