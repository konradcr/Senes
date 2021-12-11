//
//  NewActivity.swift
//  senes
//
//  Created by Apprenant 49 on 07/12/2021.
//


import SwiftUI

struct NewActivity: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var user: CurrentUser
    
    @Binding var isPresented : Bool
    @State var newActivity: Activity = Activity(description: "Description de l'activité... \n \n")
    @State var sendNewPost = false
    
    @State private var totalChars = 0
    @State private var lastText = ""
    let placeHolderDescription: String = "Description de l'activité... \n \n"
    
    @State var centerOfInterest : CenterOfInterest = .arts
    @State var loaderPicture = LoaderPicture(isImagePickerShown: false,
                                             sourceType: UIImagePickerController.SourceType.photoLibrary)
    var isValid: Bool {
        return newActivity.title != "" && newActivity.location != "" && newActivity.description != ""
    }
    
    var colorBtnIfIsValid : Color {
        isValid ? .greenContent : .greenAction
    }
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField(text: $newActivity.title) { Text("Titre") }
                        TextField(text: $newActivity.location) { Text("Lieu") }
                        HStack{
                            Text("Centre d'intérêt")
                            Spacer()
                            Picker("Choisissez une catégorie", selection: $newActivity.centerOfInterest) {
                                ForEach(CenterOfInterest.allCases, id: \.self) { interet in
                                    Text(interet.rawValue)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    
                    Section {
                        DatePicker("Début", selection: $newActivity.dateStartActivity)
                        DatePicker("Fin", selection: $newActivity.dateEndActivity)
                        Stepper("\(newActivity.numberParticipants) participants max",
                                value: $newActivity.numberParticipants, in: 2...100)
                    }
                    
                    ZStack {
                        TextEditor(text: $newActivity.description)
                            .foregroundColor(newActivity.description == placeHolderDescription ? .gray : .primary)
                            .padding(.horizontal)
                            .cornerRadius(20)
                            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5)))
                            .onChange(of: newActivity.description) { text in
                                totalChars = text.count
                                
                                if totalChars <= 400 {
                                    lastText = text
                                } else {
                                    self.newActivity.description = lastText
                                }
                            }
                            .onTapGesture {
                                if newActivity.description == placeHolderDescription {
                                    newActivity.description = ""
                                }
                            }
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("\(totalChars) / 400")
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                                    .padding(5)
                            }
                        }
                        
                    }
                }
                
                if let image = loaderPicture.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 110, alignment: .center)
                }
                
                
                HStack{
                    Spacer()
                    Button{
                        loaderPicture.isImagePickerShown.toggle()
                    } label: {
                        Image(systemName: "camera.fill")
                    }
                    .buttonPrincipalStyle(colorBck: Color.greenContent, foregroundColor: .white)
                    
                    Spacer()
                    Button("Poster") {
                        user.activities.append(newActivity)
                        //                newActivity = .empty
                        sendNewPost = true
                    }
                    .buttonPrincipalStyle(colorBck: isValid ? Color.greenAction : .gray, foregroundColor: .white)
                    .disabled(isValid)
                    Spacer()
                }
                
                
            }
            .sheet(isPresented: $loaderPicture.isImagePickerShown, onDismiss: loadImage) {
                ImagePicker(inputImage: self.$loaderPicture.inputImage, sourceType: self.loaderPicture.sourceType) }
            .alert(isPresented: $sendNewPost) {
                Alert(
                    title: Text("Activité postée !"),
                    message: Text("\nVotre activité a bien été envoyé sur le fil"),
                    dismissButton: .default(Text("OK"),action: {
                        isPresented = false
                    })
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
            .navigationTitle("Poster une activité")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func loadImage() {
        guard let inputImage = loaderPicture.inputImage else { return }
        loaderPicture.image = Image(uiImage: inputImage)
    }
}




struct NewActivity_Previews: PreviewProvider {
    static var previews: some View {
        NewActivity(user: CurrentUser(), isPresented: .constant(true))
    }
}
