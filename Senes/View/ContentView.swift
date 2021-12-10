//
//  ContentView.swift
//  TestJson
//
//  Created by Konrad Cureau on 10/12/2021.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingOnboarding = true
    @StateObject var currentUser = CurrentUser()
    
    var posts: [Post] = Bundle.main.decode([Post].self, from: "posts.json")
    
    var body: some View {
        if isShowingOnboarding {
            EmptyView()
            OnBoardingView(isShowingOnboarding: $isShowingOnboarding, currentUser: currentUser)
        } else  {
            TabView{
                Communaute(currentUser: currentUser, posts: posts)
                    .tabItem{
                        Image(systemName: "person.3.fill")
                        Text("Communauté")
                    }
                Text("Recherche")
//                Recherche(interests: Interest.interests)
                    .tabItem{
                        Image(systemName: "calendar")
                        Text("Activités")
                    }
                Text("Messagerie")
//                Messagerie()
                    .tabItem{
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                        Text("Messagerie")
                    }
                Text("Profil")
//                MyProfilView(currentUser: currentUser)
                    .tabItem{
                        Image(systemName: "person.circle.fill")
                        Text("Mon Profil")
                    }
            }
            .accentColor(Color.greenAction)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentUser: CurrentUser())
    }
}
