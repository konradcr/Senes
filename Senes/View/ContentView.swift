//
//  ContentView.swift
//  TestJson
//
//  Created by Konrad Cureau on 10/12/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var tabController = TabController()
    @StateObject var currentUser = CurrentUser()
    @StateObject var activitiesViewModel = ActivitiesViewModel()
    @StateObject var postsViewModel = PostViewModel()
    
    @State private var isShowingOnboarding = true

    var interests: [Interest] = Bundle.main.decode([Interest].self, from: "interests.json")
    
    var body: some View {
        if isShowingOnboarding {
            OnBoardingView(isShowingOnboarding: $isShowingOnboarding, currentUser: currentUser)
        } else  {
            TabView(selection: $tabController.activeTab) {
                Communaute(currentUser: currentUser, activitiesViewModel: activitiesViewModel, postsViewModel: postsViewModel)
                    .tabItem{
                        Image(systemName: "person.3.fill")
                        Text("Communauté")
                    }
                    .tag(Tab.community)
                    

                ActivitiesView(currentUser: currentUser, activitiesViewModel: activitiesViewModel, interests: interests)
                    .tabItem{
                        Image(systemName: "calendar")
                        Text("Activités")
                    }
                    .tag(Tab.activities)

                Messagerie(currentUser: currentUser)
                    .tabItem{
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                        Text("Messagerie")
                    }
                    .tag(Tab.messages)

                MyProfilView(currentUser: currentUser)
                    .tabItem{
                        Image(systemName: "person.fill")
                        Text("Mon Profil")
                    }
                    .tag(Tab.profil)
            }
            .environmentObject(tabController)
            .accentColor(Color.greenAction)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentUser: CurrentUser())
    }
}
