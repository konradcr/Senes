//
//  InscriptionScreen.swift
//  senes
//
//  Created by Apprenant 49 on 08/12/2021.
//

import SwiftUI

struct InscriptionView: View {
    
    @Environment(\.presentationMode) var presentationModal
    @ObservedObject var currentUser: CurrentUser
    
    @Binding var isShowingInscription: Bool
    
    @State var nom: String = ""
    @State var ville: String = ""
    @State var email : String = ""
    @State var interestsChoosed : [CenterOfInterest] = []
    @State var profilPic: UIImage?
    @State var isShowingImagePicker = false
    @State var description : String = ""
    
    var interests : [Interest]
    
    var users: [Person] = Bundle.main.decode([Person].self, from: "users.json")
    var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json")
    
    
    var body: some View {
        NavigationView{
            
            Form {
                Text("Bienvenue sur Senes !")
                    .bold()
                    .font(.title)
                Section(header: Text("Inscription")) {
                    TextField("Votre mail", text: $email)
                    TextField("Nom d'utilisateur", text: $nom)
                    TextField("Ville",text: $ville)
                    TextField("Dites nous ce que vous recherchez!", text: $description)
                        .lineLimit(10)
                    Button(action: {isShowingImagePicker.toggle()}) {
                        HStack{
                            Image(systemName: "camera.fill");
                            Text("Ajoutez une photo de profil")
                        }
                    }
                    
                }
                Divider()
                Section(header: Text("Choissisez vos premiers centres d'intérets")) {
                    ForEach(interests) { i in
                        
                        Button {
                            if interestsChoosed.contains(i.category) {
                                if let index = interestsChoosed.firstIndex(of: i.category)
                                {
                                    interestsChoosed.remove(at: index)
                                    
                                }
                            }else {
                                interestsChoosed.append(i.category)
                                
                            }
                            print(interestsChoosed)
                        } label: {
                            ZStack {
                                Image(i.catImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height:130)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(interestsChoosed.contains(i.category) ? Color.greenAction : .clear, lineWidth: 10)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                                Text(i.category.rawValue)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                Button(action: { createUser() } ) {
                    Text("S'inscrire")
                }
                
                
            }.sheet(isPresented: $isShowingImagePicker){
                ImagePicker(inputImage: $profilPic, sourceType: .photoLibrary)
            }
        }
    }
    func createUser() {
//        currentUser.name = nom
//        currentUser.city = ville
//        currentUser.centersOfInterest = interestsChoosed
//        currentUser.profilPic
        currentUser.friends = users.filter { $0.isYourFriend == true }
//        currentUser.chats = []
//        currentUser.myPost = []
        currentUser.activities = activities.filter { $0.participating == true }
//        currentUser.isCertified = false
//        currentUser.description = description
        
        isShowingInscription = false
        
    }
}

struct InscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        InscriptionView(currentUser: CurrentUser(), isShowingInscription: .constant(true), interests: Interest.interests)
    }
}
