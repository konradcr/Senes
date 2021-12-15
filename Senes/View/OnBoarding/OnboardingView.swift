//
//  OnboardingView.swift
//  senes
//
//  Created by Apprenant 49 on 08/12/2021.
//

import SwiftUI

struct OnBoardingView: View {
    
    @Binding var isShowingOnboarding : Bool
    @ObservedObject var currentUser: CurrentUser
    
    var body: some View {
        TabView {
            PageView(
                currentUser: currentUser, isShowingOnboarding: $isShowingOnboarding,
                title: "Rencontrez et partagez ",
                subtitle: "Votre prochain camarade de belotte est peut-être moins loin que vous ne le croyez ! ",
                image: "avatars-1",
                showDismissButon:false,
                color: Color.grisContent
            )
            PageView(
                currentUser: currentUser, isShowingOnboarding: $isShowingOnboarding,
                title: "Discutez ! ",
                subtitle: "Notre messagerie simple permet de vous rapprocher de n'importe quel passioné en un rien de temps.",
                image:"discussion-1" ,
                showDismissButon:false,
                color: Color.grisContent
            )
            PageView(
                currentUser: currentUser, isShowingOnboarding: $isShowingOnboarding,
                title: "Lancez vous",
                subtitle: "Très peu pour vous la vie d'hermite ? Sur Senes, vous n'êtes plus seul, organisez et participez des activitées entre membres !",
                image: "activités mamie",
                showDismissButon: true,
                color: Color.grisContent
            )
        }
        .edgesIgnoringSafeArea(.all)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        
    }
}


struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(isShowingOnboarding: .constant(false), currentUser: CurrentUser())
    }
}
