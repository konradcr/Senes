//
//  Recherche.swift
//  senes
//
//  Created by Apprenant 49 on 01/12/2021.
//

import SwiftUI

struct ActivitiesView: View {
    @Environment(\.dynamicTypeSize) var sizeCategory

    @ObservedObject var currentUser: CurrentUser
    @ObservedObject var activitiesViewModel: ActivitiesViewModel
    
    @State private var isAddingNewActivity = false
    @State var sendNewActivity: Bool = false
    
    let interests : [Interest]
    
    var gridLayout: [GridItem] {
        if sizeCategory > DynamicTypeSize.large {
            return [
                GridItem(.flexible())
            ]
        } else {
            return [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns : gridLayout, alignment : .center){
                    
                    ForEach(interests){ interest in
                        
                        NavigationLink(destination: InterestActivity(currentUser: currentUser, activities: activitiesViewModel.activitiesSorted, interest: interest.category)) {
                            
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
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .font(.title)
                                        
                                        
                                        
                                }
                                
                                .padding(.leading,5)
                            }
                            .padding(10)
                        }
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingNewActivity.toggle()
                    } label: {
                        Image(systemName: "calendar.badge.plus")
                    }
                }
            }
            .navigationTitle("Activités")
            .sheet(isPresented: $isAddingNewActivity) {
                NewActivity(user: currentUser, activitiesViewModel: activitiesViewModel, isPresented: $isAddingNewActivity) }
            .alert("Votre post a bien eté envoyé sur le fil", isPresented: $sendNewActivity) {
                Button("OK", role: .cancel) { }
            }
        }
        

    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)
    static var interests: [Interest] = Bundle.main.decode([Interest].self, from: "interests.json")
    
    static var previews: some View {
        ActivitiesView(currentUser: CurrentUser(), activitiesViewModel: ActivitiesViewModel(), interests: interests)
//            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)

    }
}

