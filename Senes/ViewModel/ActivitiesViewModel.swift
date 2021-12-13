//
//  ActivitiesViewModel.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

class ActivitiesViewModel: ObservableObject {    
    @Published var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)
    
    func addActivity(_ activity: Activity) {
        activities.append(activity)
    }

    func removeActivity(_ activity: Activity) {
        if let index = activities.firstIndex(of: activity) {
            activities.remove(at: index)
        }
    }
}
