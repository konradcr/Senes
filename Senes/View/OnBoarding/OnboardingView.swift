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
        TabView{
            
            PageView(
                currentUser: currentUser, isShowingOnboarding: $isShowingOnboarding,
                     title: "Rencontre amicale",
                     subtitle: "Papi fun est chaud",
                     image: "avatars",
                     showDismissButon:false,
                     color: Color.grisContent
            )
            PageView(
                currentUser: currentUser, isShowingOnboarding: $isShowingOnboarding,
                     title: "Discutez ",
                     subtitle: "Restons connectés !",
                     image:"discussion" ,
                     showDismissButon:false,
                     color: Color.grisContent
            )
            PageView(
                currentUser: currentUser, isShowingOnboarding: $isShowingOnboarding,
                     title: "Bougez",
                     subtitle: "Participez à des activités avec d'autres membres de la communauté!",
                     image: "activités mamie",
                     showDismissButon:false,
                     color: Color.grisContent
            )
            PageView(
                currentUser: currentUser, isShowingOnboarding: $isShowingOnboarding,
                     title: "Home",
                     subtitle: "discussion",
                     image: "discussion",
                     showDismissButon:true,
                     color: Color.grisContent
            )
               
            
            
        } .edgesIgnoringSafeArea(.all)
        .tabViewStyle(PageTabViewStyle())
        
    }
}


        
    


struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(isShowingOnboarding: .constant(false), currentUser: CurrentUser())
    }
}
