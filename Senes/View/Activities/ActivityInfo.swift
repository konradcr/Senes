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
    @State private var weather = Weather()
    @State private var forecastDay = Forecastday()
    
    let activity: Activity
    
    var body: some View {
        ScrollView {
            Image(activity.pictureActivity ?? activity.centerOfInterest.rawValue)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding(10)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.greenContent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                VStack {
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
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack {
                                        Text("Du " + activity.dateStartActivity.formatted(date: .abbreviated, time: .shortened))
                                            .font(.title2)
                                        Text("au " + activity.dateEndActivity.formatted(date: .abbreviated, time: .shortened))
                                            .font(.title2)
                                    }
                                    Spacer()
                                    if let weatherForecast = forecastDay.day.condition.returnSFWeather(condition: forecastDay.day.condition.text) {
                                        Image(systemName: weatherForecast)
                                            .font(.title)
                                    }
                                }
                            }
                        }
                        
                        Divider()
                        
                        Group {
                            HStack {
                                if dynamicSize <= DynamicTypeSize.large {
                                    Image(systemName: "person.3.fill")
                                }
                                Text("Participants max : \(activity.numberParticipants)")
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
                        
                    }
                    .padding(.all,10)
                }
                
                VStack {
                    Spacer()
                    Button {
                        if currentUser.isParticipating(activity: activity) {
                            currentUser.unparticipateToActivity(activity: activity)
                        } else {
                            currentUser.participateToActivity(activity: activity)
                        }
                    } label: {
                        Text(currentUser.isParticipating(activity: activity) ? "Ne plus participer" : "Participer")
                            .frame(width: 160)
                    }
                    .reduceDynamicSize()
                    .buttonPrincipalStyle(colorBck: currentUser.isParticipating(activity: activity) ? Color.red.opacity(0.6) : Color.greenAction, foregroundColor: Color.white)
                    
//                    .fixedSize(horizontal: true, vertical: false)
                    .padding()
                }
                
            }
            .padding(10)
            
        }
        .navigationBarTitle("\(activity.title)")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadData(activity: activity)
        }
    }
    
    func loadData(activity: Activity) async {
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=2fb44da9222c49bc957101121211312&q=\(activity.location)&days=3&aqi=no&alerts=no") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Weather.self, from: data) {
                weather = decodedResponse
                forecastDay = activity.determineWeather(weather: decodedResponse)
            }
        } catch {
            print("Invalid data")
        }
    }
}


struct ActivityInfo_Previews: PreviewProvider {
    static let activities = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)
    
    static var previews: some View {
        ActivityInfo(currentUser: CurrentUser(), activity: activities[0])
            .environment(\.locale, Locale(identifier: "fr"))
//                    .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
