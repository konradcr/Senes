//
//  ListActivtityProfilRow.swift
//  senes
//
//  Created by Konrad Cureau on 03/12/2021.
//

import SwiftUI

struct ListActivtityProfilRow: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text(activity.title)
                    .bold()
                HStack {
                    Text("Le " + activity.dateStartActivity.formatted(date: .abbreviated, time: .shortened))
                    Text("à " + activity.location)
                }
            }
            .foregroundColor(activity.dateStartActivity > Date() ? .black : .gray)
            Spacer()
        }
    }
}

struct ListActivtityProfilRow_Previews: PreviewProvider {
    static var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)

    static var previews: some View {
        ListActivtityProfilRow(activity: activities[0])
    }
}
