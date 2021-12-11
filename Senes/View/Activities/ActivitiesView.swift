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
            ScrollView {
                LazyVGrid(columns : gridLayout, alignment : .center){
                    
                    ForEach(interests){ interest in
                        
                        NavigationLink(destination: InterestActivity(activities: activities, interest: interest.category)) {
                            
                            ZStack(alignment: .leading) {
                                GeometryReader { gr in
                                    Image(interest.catImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: gr.size.width)
                                        .overlay(Color.black.opacity(0.45))
                                }
                                .cornerRadius(20)
                                .clipped()
                                .aspectRatio(1, contentMode: .fit)
                                HStack(alignment: .center){
                                    Text(interest.category.rawValue)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .padding(.leading,5)
                            }
                            .padding(10)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Activités")
        }
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)
    static var interests: [Interest] = Bundle.main.decode([Interest].self, from: "interests.json")
    
    static var previews: some View {
        ActivitiesView(interests: interests, activities: activities)
    }
}

