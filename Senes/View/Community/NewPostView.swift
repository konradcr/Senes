//
//  NewPostView.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import SwiftUI

struct NewPostView: View {
    @EnvironmentObject private var tabController: TabController

    @ObservedObject var currentUser: CurrentUser
    @ObservedObject var postsViewModel: PostViewModel
    
    @State var sendNewPost = false
    @State var newActivity: Activity = Activity()
    @State private var text: String = "Ecrit un message..."
    @State private var totalChars = 0
    @State private var lastText = ""
    @State var loaderPicture = LoaderPicture(isImagePickerShown: false,
                                             sourceType: UIImagePickerController.SourceType.photoLibrary)
    
    let placeHolder = "Ecrit un message..."
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    tabController.open(.profil)
                } label: {
                    Image(currentUser.profilPic)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                
                ZStack {
                    TextEditor(text: $text)
                        .foregroundColor(text == placeHolder ? .gray : .primary)
                        .padding()
                        .cornerRadius(20)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5)))
                        .onTapGesture {
                            if self.text == placeHolder {
                                self.text = ""
                            }
                        }
                        .onChange(of: text) { text in
                            totalChars = text.count
                            
                            if totalChars <= 400 {
                                lastText = text
                            } else {
                                self.text = lastText
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
                .frame(maxHeight: 80)
            }
            HStack {
                Spacer()
                Button { } label: {
                    Image(systemName: "camera")
                }
                .font(.title3)
                .buttonPrincipalStyle(colorBck: .white, foregroundColor: .black)
                .padding(.horizontal)

                Button("Poster") {
                    createNewPost()
                    
                }
                .font(.title3)
                .buttonPrincipalStyle(colorBck: Color.greenAction, foregroundColor: .white)
                .padding(.horizontal)
                .padding(.trailing)
            }
        }.padding()
    }
    
    func createNewPost() {
        var newPost = Post()
        newPost.userID = String(currentUser.id)
        newPost.postImage = "" /*loaderPicture.image*/
        newPost.description = text
        postsViewModel.addPost(newPost)
        print(newPost)
        sendNewPost = true
        
        text = placeHolder
        loaderPicture.image = nil
//        UIApplication.shared.endEditing()
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(currentUser: CurrentUser(), postsViewModel: PostViewModel())
    }
}
