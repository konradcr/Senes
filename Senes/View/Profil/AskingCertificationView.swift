//
//  AskingCertificationView.swift
//  senes
//
//  Created by Konrad Cureau on 07/12/2021.
//

import SwiftUI

struct AskingCertificationView: View {
    @ObservedObject var currentUser: CurrentUser
    
    @Binding var isCertificationAsked: Bool
    
    @State private var isShowImagePicker = false
    @State private var isShowDocumentPicker = false
    @State private var selfie: UIImage?
    @State private var imageID: UIImage?
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                
                Image(currentUser.profilPic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 140)
                    .shadow(radius: 7)
                Text(currentUser.name)
                    .font(.title2)
                    .bold()
                Text("Sur notre app, un maître mot : sécurité. Joins une pièce d'identité et bénéficie du statut \"Profil certifié\" pour encore plus d'interactions. On vérifiera qu'il s'agit bien de toi grâce au selfie que tu peux prendre ici !")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Group {
                    Button(action: {isShowImagePicker.toggle()}) {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Ajouter une photo de moi")
                        }
                    }
                    .frame(maxWidth: 300)
                    .buttonImportMediaStyle(
                        backgroundColor: selfie != nil ? Color.greenContent : .grayBackground,
                        foregroundColor: selfie != nil ? .white : .gray
                    )
                    .sheet(isPresented: $isShowImagePicker) {
                        ImagePicker(inputImage: $selfie, sourceType: .camera)
                    }
                    
                    Button(action: {isShowDocumentPicker.toggle()}) {
                        HStack {
                            Image(systemName: "person.text.rectangle.fill")
                            Text("Ajouter une pièce d'identité")
                        }
                    }
                    .frame(maxWidth: 300)
                    .buttonImportMediaStyle(
                        backgroundColor: imageID != nil ? Color.greenContent : .grayBackground,
                        foregroundColor: imageID != nil ? .white : .gray
                    )
                    .fileImporter(isPresented: $isShowDocumentPicker, allowedContentTypes: [.image], onCompletion: importID)
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
            
            Button("Envoyer") {
                if selfie != nil && imageID != nil {
                    isCertificationAsked = true
                } else {
                    showingAlert = true
                }
            }
            .font(.title3)
            .buttonPrincipalStyle(colorBck: Color.greenAction, foregroundColor: .white)
            .padding(.vertical)
            
        }
        .alert("Renseigne tous les documents nécessaires !", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
    }
    
    func importID(_ result: Result<URL, Error>) {
        do{
            let fileUrl = try result.get()
            print(fileUrl)
            
            guard fileUrl.startAccessingSecurityScopedResource() else { return }
            if let imageData = try? Data(contentsOf: fileUrl),
               let image = UIImage(data: imageData) {
                self.imageID = image
            }
            fileUrl.stopAccessingSecurityScopedResource()
        } catch{
            print ("error reading")
            print (error.localizedDescription)
        }
    }
}

struct AskingCertificationView_Previews: PreviewProvider {
    static var previews: some View {
        AskingCertificationView(currentUser: CurrentUser(), isCertificationAsked: .constant(false))
    }
}
