
//  PostView.swift
//  senes
//
//  Created by Apprenant 49 on 03/12/2021.
//

import SwiftUI


struct PostView: View {
    
    @ObservedObject var currentUser: CurrentUser
        
        @State var description: String = "Ecrit un message..."
        
        @State var sendNewPost: Bool = false
        @Binding var loaderPicture: LoaderPicture
        var posts: [Post] 
        
        var isValid : Bool {
            return description == "Ecrit un message..."
        }
            
        var colorbtnIfIsValidColor: Color {
            isValid ? .greenContent : .greenAction
        }
        
        var resizer : CGFloat {
            description != "Ecrit un message..." ? 3 : 6
        }
            
        
        var body: some View {
            GeometryReader { geo in
                HStack {
                    Spacer()
                    Image(currentUser.profilPic)
                        .resizable()
                        .modifierForImageWithGeo(geo: geo)
                    
                    VStack{
                        TextView(textDescription: $description)
                            .modifier(ModifierForTextView(geo: geo))
                        
                        HStack {
                            Spacer()

                            Button {
                                var newPost = Post()
                                newPost.userID = String(currentUser.id)
                                newPost.postImage = "" /*loaderPicture.image*/
                                newPost.description = description
//                                posts.append(newPost)
                                
                                sendNewPost = true

                                description = "Ecrit un message..."
                                loaderPicture.image = nil
                                UIApplication.shared.endEditing()
                            } label: {
                                
                                Text("Poster")
                                    .font(.title)
                                    .bold()
                            }
                            .modifierForButonWithGeo(colorBck: colorbtnIfIsValidColor, foregroundColor: .white, geo: geo)
                            .disabled(isValid)
                            
                            Spacer()
                            
                            Button {
                                
                                loaderPicture.sourceType = .photoLibrary
                                loaderPicture.isImagePickerShown = true
                                
                            } label: {
                                if let sImage = loaderPicture.image {
                                    sImage
                                        .resizable()
                                        .modifier(ImageModifier())
                                } else {
                                    Image(systemName: "camera.fill")
                                        .resizable()
                                        .modifier(ImageModifier())
                                }
                            }
                            .modifierForButonWithGeo(colorBck: .white, foregroundColor: .black, geo: geo)
                            Spacer()
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.size.height / resizer)
            .alert(isPresented: $sendNewPost) {
                Alert(
                    title: Text("✅ Envoyé !"),
                    message: Text("\nVotre post a bien était envoyé sur le fil")
                )
            }.padding()

        }
        
}
