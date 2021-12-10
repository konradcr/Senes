//
//  PostDetailView.swift
//  senes
//
//  Created by Apprenant 49 on 06/12/2021.
//

import SwiftUI

struct PostDetailView: View {
    var currentUser: CurrentUser
    
    let post: Post
    let user: Person
    
    var body: some View {
        
        VStack(alignment:.leading){
            VStack {
                VStack{
                    HStack{
                        NavigationLink(destination: Text("DetailProfil")/*ProfilOtherUserView(user: post.user, currentUser: currentUser )*/) {
                            Image(user.profilPic)
                                .resizable()
                                .frame(width: 50, height:50)
                        }
                        .clipShape(Circle())
                        VStack(alignment: .leading){
                            Text(user.name)
                                .fontWeight(.bold)
                            Text(post.datePost)
//                            Text(post.datePost, format: .dateTime.day().month().year())
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
                Text(post.description)
            }
            .padding()

            if let image = post.postImage {
                Image(image)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }

            Spacer()

        }
        .cardStyle()
            .navigationTitle("Détail")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    init(post: Post, currentUser: CurrentUser) {
        self.post = post
        self.currentUser = currentUser
        let users: [Person] = Bundle.main.decode([Person].self, from: "users.json")
        var userMatch = Person()
        
        if let match = users.first(where: {$0.id == post.userID}) {
            userMatch = match
        }
        
        self.user = userMatch
    }
    
}


struct PostDetailView_Previews: PreviewProvider {
    static var posts: [Post] = Bundle.main.decode([Post].self, from: "posts.json")
    
    static var previews: some View {
        PostDetailView(post: posts[0], currentUser: CurrentUser())
    }
}
