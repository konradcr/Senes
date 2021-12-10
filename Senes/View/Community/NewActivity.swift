//
//  NewActivity.swift
//  senes
//
//  Created by Apprenant 49 on 07/12/2021.
//


import SwiftUI

struct NewActivity: View {
    @ObservedObject var user: CurrentUser
    
    @Binding var isPresented : Bool
    @State var newActivity: Activity = Activity()
    @State var sendNewPost = false
    
    @State private var dateStart = Date()
    @State private var dateEnd = Date()
    
    
    @State var centerOfInterest : CenterOfInterest = .arts
    @State var loaderPicture = LoaderPicture(isImagePickerShown: false,
                                             sourceType: UIImagePickerController.SourceType.photoLibrary)
    
    var isValid : Bool {
        return newActivity.title == "" || newActivity.location == ""
    }
    
    var colorBtnIfIsValid : Color {
        isValid ? .greenContent : .greenAction
    }
    
    
    var body: some View {
        
        VStack{
            HStack {
                Button {
                    isPresented = false
                } label: {
                    Text("Annuler")
                        .padding()
                }
                Spacer()
            }
            List{
                TextField(text: $newActivity.title) { Text("Titre") }
                
                TextField(text: $newActivity.location) { Text("Lieu") }
                
                HStack{
                    
                    Text("Categorie")
                    
                    Spacer()
                    
                    Picker(selection: $newActivity.centerOfInterest) {
                        ForEach(CenterOfInterest.allCases, id: \.self) { // KeyPath
                            interet in
                            Text(interet.rawValue)
                        }
                    } label: {}
                    .pickerStyle(.menu)
                }
                
                DatePicker("Début", selection: $dateStart)
                
                DatePicker("Fin", selection: $dateEnd)
                
                TextField("Nombre de participant",
                          value: $newActivity.numberParticipants,
                          format: .number)
                    .keyboardType(.numberPad)
                
                
                HStack{
                    Spacer()
                    Button{
                        loaderPicture.isImagePickerShown.toggle()
                        
                    } label: {
                        
                        if loaderPicture.image != nil {
                            loaderPicture.image!
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .padding()
                        } else {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .padding()
                        }
                    }
                    .foregroundColor(.white)
                    .background(Color.greenContent)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 1, x: -3, y: 3)
                    Spacer()
                }
                TextView(textDescription: $newActivity.description)
                    .border(.gray, width: 2)
                    .cornerRadius(4)
                    .padding().frame(height: UIScreen.main.bounds.size.height / 4)
                HStack{
                    Spacer()
                    
                    Button{
                        
                        newActivity.dateStartActivity = dateStart.descriptiveString(dateStyle: .medium)
                        newActivity.dateEndActivity = dateEnd.descriptiveString(dateStyle: .medium)
                        user.activities.append(newActivity)
                        //                newActivity = .empty
                        sendNewPost = true
                        
                    } label: {
                        Text("Poster sur le fil")
                            .bold()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(colorBtnIfIsValid)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 1, x: -3, y: 3)
                    Spacer()
                }
                .disabled(isValid)
            }
        }.sheet(isPresented: $loaderPicture.isImagePickerShown, onDismiss: loadImage) {
            ImagePicker(inputImage: self.$loaderPicture.inputImage, sourceType: self.loaderPicture.sourceType) }
        .alert(isPresented: $sendNewPost) {
            Alert(
                title: Text("✅ Envoyé !"),
                message: Text("\nVotre post a bien était envoyé sur le fil"),
                dismissButton: .default(Text("OK"),action: {
                    isPresented = false
                })
            )
        }.padding()
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
