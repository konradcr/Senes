//
//  ProfilOtherUserView.swift
//  senes
//
//  Created by Konrad Cureau on 08/12/2021.
//

import SwiftUI

struct ProfilOtherUserView: View {
    @ObservedObject var currentUser: CurrentUser
    
    let user: Person
    
    var body: some View {
       
            VStack(alignment: .leading) {
                PresentationProfilUserCard(user: user)
                HStack {
                    Spacer()
                    Button("Contacter") {
                        // action contact
                    }
                    .font(.body)
                    .buttonPrincipalStyle(colorBck: Color.greenContent, foregroundColor: Color.white)
                    Spacer()
                    Button(currentUser.isYourFriend(user: user) ? "Retirer" : "Ajouter") {
                        if currentUser.isYourFriend(user: user) {
                            currentUser.removeFriend(user: user)
                        } else {
                            currentUser.addFriend(user: user)
                        }
                    }
                    .font(.body)
                    .buttonPrincipalStyle(colorBck: currentUser.isYourFriend(user: user) ? Color.red.opacity(0.6) : Color.grayBackground, foregroundColor: currentUser.isYourFriend(user: user) ? Color.white : Color.black)
                    Spacer()
                }
                .padding(.bottom)
                Text("À propos de \(user.name)")
                    .foregroundColor(Color.greenAction)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(alignment: .leading)
                
                DescriptionUserView(user: user)
            }
            .padding()
    }
}

struct PresentationProfilUserCard: View {
    let user: Person

    var body: some View {
        HStack {
            Image(user.profilPic)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 140)
                .shadow(radius: 7)
                .padding()
            
            VStack (alignment: .leading){
                HStack {
                    Text(user.name)
                        .bold()
                    Spacer()
                    Image(systemName: user.isCertified ? "checkmark.seal.fill" : "xmark.seal.fill")
                        .foregroundColor(user.isCertified ? Color.greenAction : .gray)
                }
                .font(.title)
                Text(user.city)
                    .font(.title2)
                
                HStack {
                    ForEach(user.centersOfInterest, id:\.self) { interest in
                        CenterOfInterestTag(tag: interest)
                            
                    }
                }
                
            }
            .padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.white)
        .cardStyle()
        .padding(.vertical)
    }
}

struct DescriptionUserView: View {
    let user: Person
    
    var body: some View {
        VStack {
            Text(user.description)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.white)
                .cardStyle()
            Spacer()
        }
        .padding(.vertical)
    }
}

struct ProfilOtherUserView_Previews: PreviewProvider {
    static var users: [Person] = Bundle.main.decode([Person].self, from: "users.json")

    static var previews: some View {
        ProfilOtherUserView(currentUser: CurrentUser(), user: users[0])
    }
}
