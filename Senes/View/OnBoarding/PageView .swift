//
//  PageView .swift
//  senes
//
//  Created by Apprenant 49 on 08/12/2021.
//

import SwiftUI



struct PageView : View {
    @ObservedObject var currentUser: CurrentUser
    @State private var isShowingInscription = false
    @Binding var isShowingOnboarding : Bool
    @State private var animationAmount = 1.0
    
    let title:String
    let subtitle:String
    let image:String
    let showDismissButon:Bool
    let color:Color
    
    var body: some View {
        VStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(animationAmount / 2)
                .animation(
                    .easeIn(duration: 0.5),value: animationAmount
                )
                .onAppear {
                    animationAmount = 2
                }
            
            Text(title)
                .foregroundColor(Color.greenAction)
                .bold()
                .padding()
                .font(.largeTitle)
                .scaleEffect(animationAmount / 2)
                .animation(
                    .easeIn(duration: 1),value: animationAmount)
                .onAppear {
                    animationAmount = 2
                }
            
            Text(subtitle)
                .font(.title3)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.greenAction)
                .padding()
            
            if showDismissButon {
                Button(action:{
                    isShowingInscription.toggle()
                    
                }, label: {
                    
                    Text("Commencez")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.greenAction)
                        .cornerRadius(10)
                    
                })
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .sheet(isPresented: $isShowingInscription, onDismiss: { isShowingOnboarding = false }){
                InscriptionView(currentUser: currentUser, isShowingInscription: $isShowingInscription)
                
            }
    }
}


struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(currentUser: CurrentUser(), isShowingOnboarding: .constant(false)
                 , title: "Push Notifs",
                 subtitle: "Enable Notifs",
                 image: "discussion",
                 showDismissButon:false,
                 color: Color.grisContent)
    }
}

