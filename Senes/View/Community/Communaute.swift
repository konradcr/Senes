//
//  Communaute.swift
//  senes
//
//  Created by Apprenant 49 on 01/12/2021.
//

import SwiftUI

struct Communaute: View {
    @ObservedObject var currentUser: CurrentUser
    @ObservedObject var activitiesViewModel: ActivitiesViewModel
    @ObservedObject var postsViewModel: PostViewModel
    
    @State var isNewActivityShow : Bool = false
    @State var sendNewPost : Bool = false
    @State var loaderPicture = LoaderPicture(
        isImagePickerShown: false,
        sourceType: UIImagePickerController.SourceType.photoLibrary
    )
    
    var body: some View {
        
        NavigationView {
            VStack {
                ZStack {
                    VStack{
                        PostView(currentUser: currentUser, postsViewModel: postsViewModel, sendNewPost: sendNewPost, loaderPicture: $loaderPicture)

                        List(postsViewModel.posts) { post in
                            NavigationLink(destination:PostDetailView(post: post, currentUser: currentUser)) {
                                ExtractPost(post: post)
                                    .padding(.vertical)
                            }
                        }.listStyle(PlainListStyle())
                    }
                    
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action:{
                                isNewActivityShow.toggle()
                            }, label: {
                                Image(systemName: "calendar.badge.plus")
                                    .reduceDynamicSize()
                                    .modifier(ImageModifierWithBackGround())
                            })
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Communauté")
        }
        .sheet(isPresented: $loaderPicture.isImagePickerShown, onDismiss: loadImage) {
            ImagePicker(inputImage: $loaderPicture.inputImage, sourceType: loaderPicture.sourceType) }
        .sheet(isPresented: $isNewActivityShow) {
            NewActivity(user: currentUser, activitiesViewModel: activitiesViewModel, isPresented: $isNewActivityShow) }
        .alert("Votre post a bien eté envoyé sur le fil", isPresented: $sendNewPost) {
            Button("OK", role: .cancel) { }
        }
    }
    
    func loadImage() {
        guard let inputImage = loaderPicture.inputImage else { return }
        loaderPicture.image = Image(uiImage: inputImage)
    }
}

struct Communaute_Previews: PreviewProvider {
    static var posts: [Post] = Bundle.main.decode([Post].self, from: "posts.json", dateDecodingStrategy: .iso8601)
    
    static var previews: some View {
        Communaute(currentUser: CurrentUser(), activitiesViewModel: ActivitiesViewModel(), postsViewModel: PostViewModel())
            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
