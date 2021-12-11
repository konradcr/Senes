//
//  ProfilOtherUserView.swift
//  senes
//
//  Created by Konrad Cureau on 08/12/2021.
//

import SwiftUI

struct ProfilOtherUserView: View {
    @ObservedObject var user: Person
    @ObservedObject var currentUser: CurrentUser
    
    var body: some View {
       
            VStack(alignment: .leading) {
                PresentationProfilUserCard(user: user)
                HStack {
                    Spacer()
                    Button("Contacter") {
                        // action contact
                    }
                    .font(.body)
                    .buttonPrincipalStyle(colorBck: Color.greenAction, foregroundColor: Color.white)
                    Spacer()
                    Button(user.isYourFriend ? "Retirer" : "Ajouter") {
                        if user.isYourFriend {
                            currentUser.removeFriend(user: user)
                            print(currentUser.friends)
                            print(Date())
                            self.user.isYourFriend = false
                            
                        } else {
                            currentUser.addFriend(user: user)
                            print(currentUser.friends)
                            self.user.isYourFriend = true
                        }
                    }
                    .font(.body)
                    .buttonPrincipalStyle(colorBck: user.isYourFriend ? Color.red.opacity(0.7) : Color.grayBackground, foregroundColor: user.isYourFriend ? Color.white : Color.black)
                    Spacer()
                }
                .padding()
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
        ProfilOtherUserView(user: users[0], currentUser: CurrentUser())
    }
}
