//
//  ActivityInfo.swift
//  senes
//
//  Created by Apprenant 49 on 06/12/2021.
//

import SwiftUI

struct ActivityInfo: View {
    @Environment(\.dynamicTypeSize) var dynamicSize
    
    @ObservedObject var currentUser: CurrentUser
    
    let activity: Activity
    
    var body: some View {
        VStack{
            Image(activity.pictureActivity ?? activity.centerOfInterest.rawValue)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding(10)
            
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .foregroundColor(.greenContent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Group{
                            HStack {
                                Group {
                                    if dynamicSize <= DynamicTypeSize.large {
                                        Image(systemName: "map.fill")
                                    }
                                    Text("Lieu")
                                        .bold()
                                }
                                .foregroundColor(.white)
                                .font(.title)
                                Spacer()
                                Button(action: {}) {
                                    Image(systemName: "bell.fill")
                                        .font(.title)
                                }
                            }
                            Text(activity.location)
                                .font(.title2)
                        }
                        
                        Divider()
                        
                        Group {
                            HStack {
                                if dynamicSize <= DynamicTypeSize.large {
                                    Image(systemName: "clock.fill")
                                }
                                Text("Date et horaires")
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .font(.title)
                            
                            Text("Du " + activity.dateStartActivity.formatted(date: .abbreviated, time: .shortened))
                                .font(.title2)
                            Text("au " + activity.dateEndActivity.formatted(date: .abbreviated, time: .shortened))
                                .font(.title2)
                        }
                        
                        Divider()
                        
                        Group {
                            HStack {
                                if dynamicSize <= DynamicTypeSize.large {
                                    Image(systemName: "person.3.fill")
                                }
                                Text("Partcipants max : \(activity.numberParticipants)")
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .font(.title)
                            
                        }
                        
                        Divider()
                        
                        Group {
                            Text("Description")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                            Text(activity.description)
                                .font(.title2)
                                .padding(.bottom, 100)
                           
                        }
                        
                        
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
                    .reduceDynamicSize()
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
            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
