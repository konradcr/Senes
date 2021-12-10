//
//  ActivityCard.swift
//  senes
//
//  Created by Apprenant 49 on 03/12/2021.
//

import SwiftUI

struct ActivityCard: View {
    let activity: Activity
    
    var body: some View {
        VStack {
            Image(activity.pictureActivity ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(activity.title)
                        .font(.title)
                        .bold()
                        .lineLimit(2)
                    Text(activity.dateStartActivity)
                    
                    Text(activity.location)
                }
                .layoutPriority(100)
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(22)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 1), lineWidth: 1)
            
        )
        .padding([.top, .horizontal])
    }
}

struct ActivityCard_Previews: PreviewProvider {
    static var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json")
    
    static var previews: some View {
        ActivityCard(activity: activities[0])
            .environment(\.locale, Locale(identifier: "fr"))
    }
}
