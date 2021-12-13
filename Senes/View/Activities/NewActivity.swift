//
//  NewActivity.swift
//  senes
//
//  Created by Apprenant 49 on 07/12/2021.
//


import SwiftUI

struct NewActivity: View {
    @ObservedObject var user: CurrentUser
    @ObservedObject var activitiesViewModel: ActivitiesViewModel
    
    @Binding var isPresented : Bool
    @State var sendNewPost = false
    
    @State var newActivity: Activity = Activity()
    @State private var title: String = ""
    @State private var location: String = ""
    @State private var description: String = "Description de l'activité... \n \n"
    @State private var totalChars = 0
    @State private var lastText = ""
    let placeHolderDescription = "Description de l'activité... \n \n"
    @State private var numberParticipants: Int = 10
    
    @State var loaderPicture = LoaderPicture(isImagePickerShown: false,
                                             sourceType: UIImagePickerController.SourceType.photoLibrary)
    
    var isValid: Bool {
        if title != "" && location != "" {
            if description != "" && description != placeHolderDescription {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField(text: $title) { Text("Titre") }
                        TextField(text: $location) { Text("Lieu") }
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
                        Stepper("\(numberParticipants) participants max",
                                value: $numberParticipants, in: 2...100)
                    }
                    
                    ZStack {
                        TextEditor(text: $description)
                            .foregroundColor(description == placeHolderDescription ? .gray : .primary)
                            .padding(.horizontal)
                            .cornerRadius(20)
                            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5)))
                            
                            .onTapGesture {
                                if self.description == placeHolderDescription {
                                    self.description = ""
                                }
                            }
                            .onChange(of: description) { text in
                                totalChars = text.count

                                if totalChars <= 400 {
                                    lastText = text
                                } else {
                                    self.description = lastText
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
                        createActivity()
                    }
                    .buttonPrincipalStyle(colorBck: isValid ? Color.greenAction : .gray, foregroundColor: .white)
                    .disabled(isValid == false)
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
                        dismiss()
                    })
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        dismiss()
                        
                    }
                }
            }
            .navigationTitle("Poster une activité")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func createActivity() {
        newActivity.title = self.title
        newActivity.location = self.location
        newActivity.description = self.description
        newActivity.numberParticipants = self.numberParticipants
       
        user.activities.append(newActivity)
        activitiesViewModel.addActivity(newActivity)
        sendNewPost = true
    }
    
    func loadImage() {
        guard let inputImage = loaderPicture.inputImage else { return }
        loaderPicture.image = Image(uiImage: inputImage)
    }
    
    func dismiss() {
        self.isPresented = false
    }
}




struct NewActivity_Previews: PreviewProvider {
    static var previews: some View {
        NewActivity(user: CurrentUser(), activitiesViewModel: ActivitiesViewModel(), isPresented: .constant(true))
    }
}
