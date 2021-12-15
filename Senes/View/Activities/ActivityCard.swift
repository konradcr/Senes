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
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(activity.dateStartActivity.formatted(date: .abbreviated, time: .omitted))
                        Text(activity.dateStartActivity.formatted(date: .omitted, time: .shortened))
                        Text(activity.location)
                        
                    }
                    .padding()
                    Spacer()
                }
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        Text(activity.title)
                            .font(.title)
                            .bold()
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
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
        List {
            ActivityCard(activity: activities[4])
                .environment(\.locale, Locale(identifier: "fr"))
        }
        
//        .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
