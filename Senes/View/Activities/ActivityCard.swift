//
//  ActivityCard.swift
//  senes
//
//  Created by Apprenant 49 on 03/12/2021.
//

import SwiftUI

struct ActivityCard: View {
    @Environment(\.dynamicTypeSize) var sizeCategory
    
    let activity: Activity
    
    var body: some View {
        VStack {
            Image(activity.pictureActivity ?? activity.centerOfInterest.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            if sizeCategory > DynamicTypeSize.large {
               
                HStack {
                    VStack(alignment: .leading) {
                            Text(activity.title)
                                .font(.title)
                                .bold()
                            Text(activity.dateStartActivity.formatted(date: .abbreviated, time: .omitted))
                            Text(activity.dateStartActivity.formatted(date: .omitted, time: .shortened))
                            Text(activity.location)
                        }
                    .padding()
                }
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        Text(activity.title)
                            .font(.title)
                            .bold()
                            .lineLimit(2)
                        Text(activity.dateStartActivity.formatted(date: .abbreviated, time: .shortened))
                        Text(activity.location)
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                .padding()
            }
            
        }
        .overlay(activity.dateStartActivity > Date() ? .clear : Color.gray.opacity(0.2))
        .background(.white)
        .cardStyle()
        .padding()
    }
}

struct ActivityCard_Previews: PreviewProvider {
    static var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)
    
    static var previews: some View {
        NavigationView {
            ActivityCard(activity: activities[0])
                .environment(\.locale, Locale(identifier: "fr"))
        }
        
            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
