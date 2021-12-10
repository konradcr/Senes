//
//  ActivityInfo.swift
//  senes
//
//  Created by Apprenant 49 on 06/12/2021.
//

import SwiftUI

struct ActivityInfo: View {
    let activity: Activity
    
    var body: some View {
        VStack{
            Image(activity.pictureActivity ?? "")
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
                        Text(activity.dateStartActivity)
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
                    Button("Participer") {
                        //
                    }
                    .buttonPrincipalStyle(colorBck: Color.greenAction, foregroundColor: .white)
                    .padding()
                }
                
            }.padding()
            
        }.navigationBarTitle("\(activity.title)")
            .navigationBarTitleDisplayMode(.inline)
    }
}


struct ActivityInfo_Previews: PreviewProvider {
    static let activities = Bundle.main.decode([Activity].self, from: "activities.json")
    
    static var previews: some View {
        ActivityInfo(activity: activities[0])
            .environment(\.locale, Locale(identifier: "fr"))
    }
}
