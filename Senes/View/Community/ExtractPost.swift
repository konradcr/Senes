//
//  PostView.swift
//  senes
//
//  Created by Apprenant 49 on 03/12/2021.
//

import SwiftUI

struct ExtractPost: View {
    let post: Post
    let user: Person
    
    init(post: Post) {
        self.post = post
        let users: [Person] = Bundle.main.decode([Person].self, from: "users.json")
        var userMatch = Person()
        
        if let match = users.first(where: {$0.id == post.userID}) {
            userMatch = match
        }
        
        self.user = userMatch
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            VStack{
                HStack{
                    Image(user.profilPic)
                        .resizable()
                        .frame(width: 50, height:50)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text(user.name)
                            .fontWeight(.bold)
                        
//                        Text(datePost, format: .dateTime.day().month().year())
                        Text(post.datePost)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            
            Text(post.description)
                .padding(.bottom)
            
            if let image = post.postImage {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
            }
            
            
            
        }
    }
}

struct ExtractPost_Previews: PreviewProvider {
    static var posts: [Post] = Bundle.main.decode([Post].self, from: "posts.json")
    
    static var previews: some View {
        ExtractPost(post: posts[0])
    }
}
