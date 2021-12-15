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
    
    var users: [Person] = Bundle.main.decode([Person].self, from: "users.json")
    var activities: [Activity] = Bundle.main.decode([Activity].self, from: "activities.json", dateDecodingStrategy: .iso8601)
    var interests: [Interest] = Bundle.main.decode([Interest].self, from: "interests.json")
    
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Inscription")) {
                    TextField("Votre mail", text: $email)
                        .keyboardType(.emailAddress)
                    TextField("Nom d'utilisateur", text: $nom)
                    TextField("Ville",text: $ville)
                    TextField("Dites nous ce que vous recherchez!", text: $description)
                        .lineLimit(10)
                }

                Button(action: {isShowingImagePicker.toggle()}) {
                    HStack{
                        Image(systemName: "camera.fill");
                        Text("Ajoutez une photo de profil")
                    }
                }
                
//                Divider()
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
                                    .opacity(interestsChoosed.contains(i.category) ? 1 : 0.6)
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
                HStack {
                    Spacer()
                    Button(action: { createUser() } ) {
                        Text("S'inscrire")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.greenAction)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                
                
            }.sheet(isPresented: $isShowingImagePicker){
                ImagePicker(inputImage: $profilPic, sourceType: .photoLibrary)
            }
            .navigationTitle("Bienvenue sur Senes !")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        currentUser.fakeInscription()
                        isShowingInscription = false
                    } label: {
                        Text("Passer")
                    }
                }
            }
            
        }
        
        
    }
    func createUser() {
        currentUser.name = nom
        currentUser.city = ville
        currentUser.centersOfInterest = interestsChoosed
        currentUser.description = description
        
        isShowingInscription = false
    }
}

struct InscriptionView_Previews: PreviewProvider {
    static var interests: [Interest] = Bundle.main.decode([Interest].self, from: "interests.json")
    
    static var previews: some View {
        InscriptionView(currentUser: CurrentUser(), isShowingInscription: .constant(true), interests: interests)
//            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
