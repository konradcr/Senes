//
//  Model.swift
//  TestJson
//
//  Created by Konrad Cureau on 10/12/2021.
//

import Foundation

class CurrentUser: Person {
    @Published var friends = [Person]()
    @Published var activities = [Activity]()
    @Published var chats = [Chat]()
    @Published var myPost = [Post]()
    
    func fakeInscription() {
        let usersJson: [Person] = Bundle.main.decode([Person].self, from: "users.json")
        let activitiesJson: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)

        self.id = UUID().uuidString
        self.name = "Germaine"
        self.city = "Lyon"
        self.description = "Passionnée d'art et de culture j'adore echanger et rencontrer de nouvelles personnnes. N'hésites pas à m'ajouter en amis pour que l'on puisse discuter à propos de nos centres d'intérêts en commun !"
        self.profilPic = "Germaine"
        self.centersOfInterest = [.arts, .jardinage]
        self.isCertified = false
        self.friends = [usersJson[0], usersJson[1], usersJson[3]]
        self.activities = [activitiesJson[0], activitiesJson[4]]
        self.chats = []
        self.myPost = []
    }
    
    // Functions for friends

    var friendsSorted: [Person] {
        return friends.sorted {
            $0.name < $1.name
        }
    }
    
    func isYourFriend(user: Person) -> Bool {
        if friends.contains(user) {
            return true
        } else {
            return false
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

    // Functions for activities

    var activitiesSorted: [Activity] {
        return activities.sorted {
            $0.dateStartActivity > $1.dateStartActivity
        }
    }

    func isParticipating(activity: Activity) ->  Bool {
        if activities.contains(activity) {
            return true
        } else {
            return false
        }
    }
    
    func participateToActivity(activity: Activity) {
        activities.append(activity)
        print(activitiesSorted)
    }

    func unparticipateToActivity(activity: Activity) {
        if let index = activities.firstIndex(of: activity) {
            activities.remove(at: index)
        }
    }
}
