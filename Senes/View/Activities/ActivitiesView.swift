//
//  Recherche.swift
//  senes
//
//  Created by Apprenant 49 on 01/12/2021.
//

import SwiftUI

struct ActivitiesView: View {
    let interests : [Interest]
    let activities: [Activity]
    
    let gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView{
            LazyVGrid(columns : gridLayout, alignment : .center){
                
                ForEach(interests){ interest in
                    
                    NavigationLink(
                        destination: InterestActivity(activities: activities, interest: interest.category),
                        label: {
                            ZStack(alignment: .leading){
                                
                                Image(interest.catImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height:180)
                                    .overlay(Color.black)
                                    .opacity(0.45)
                                    .cornerRadius(22)
                                    .padding(.trailing,12)
                                
                                HStack(alignment: .center){
                                    Text(interest.category.rawValue)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                }.padding(.all, 10)
                                    .navigationTitle("Centre d'intérêts")
                                
                                
                            }.padding(.leading, 12)
                            
                        })
                }
            }
        }
        
    }
    
}

struct ActivitiesView_Previews: PreviewProvider {
    static var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json")
    static var interests: [Interest] = Bundle.main.decode([Interest].self, from: "interests.json")
    
    static var previews: some View {
        ActivitiesView(interests: interests, activities: activities)
    }
}

