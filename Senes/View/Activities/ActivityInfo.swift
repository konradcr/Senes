//
//  ActivityInfo.swift
//  senes
//
//  Created by Apprenant 49 on 06/12/2021.
//

import SwiftUI

struct ActivityInfo: View {
    @ObservedObject var currentUser: CurrentUser

    let activity: Activity
    
    var body: some View {
        VStack{
            Image(activity.pictureActivity ?? activity.centerOfInterest.rawValue)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding(10)
            
            ZStack{
                RoundedRectangle(cornerRadius: 22)
                    .foregroundColor(.greenContent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                ScrollView {
                    VStack(alignment: .leading){
                        Group{
                            Text("Lieu")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                            
                            Text(activity.location)
                            
                                .bold()
                                .font(.title2)
                        }
                        
                        Text("Date et horaires")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                        Text(activity.dateStartActivity.formatted(date: .abbreviated, time: .shortened))
                            .bold()
                            .font(.title2)
                        
                        
                        Text("Nombre de participants")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                        
                        Text("\(activity.numberParticipants)")
                            .bold()
                            .font(.title2)
                        
                        
                        Text("Description")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                        Text(activity.description)
                            .font(.title2)
                        
                    }.padding(.all,10)
                }
                
                
                VStack {
                    Spacer()
                    Button(currentUser.isParticipating(activity: activity) ? "Ne plus participer" : "Participer") {
                        if currentUser.isParticipating(activity: activity) {
                            currentUser.unparticipateToActivity(activity: activity)
                        } else {
                            currentUser.participateToActivity(activity: activity)
                        }
                    }
                    .buttonPrincipalStyle(colorBck: currentUser.isParticipating(activity: activity) ? Color.red.opacity(0.6) : Color.greenAction, foregroundColor: Color.white)
                    .padding()
                }
                
            }.padding()
            
        }.navigationBarTitle("\(activity.title)")
            .navigationBarTitleDisplayMode(.inline)
    }
}


struct ActivityInfo_Previews: PreviewProvider {
    static let activities = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)
    
    static var previews: some View {
        ActivityInfo(currentUser: CurrentUser(), activity: activities[0])
            .environment(\.locale, Locale(identifier: "fr"))
    }
}
