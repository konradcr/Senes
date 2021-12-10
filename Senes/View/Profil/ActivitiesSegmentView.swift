//
//  ActivitiesSegmentView.swift
//  senes
//
//  Created by Konrad Cureau on 03/12/2021.
//

import SwiftUI

struct ActivitiesSegmentView: View {
    @ObservedObject var currentUser: CurrentUser
    
    var body: some View {
        
            List(currentUser.activitiesSorted) { activity in
                NavigationLink(destination: ActivityInfo(activity: activity)) {
                    ListActivtityProfilRow(activity: activity)
                }
                .listRowBackground(Color.greenContent.opacity(0.2))
                
            }
            
        
        
    }
}

struct ActivitiesSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesSegmentView(currentUser: CurrentUser())
    }
}
