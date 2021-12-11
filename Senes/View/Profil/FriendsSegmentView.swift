//
//  FriendsSegmentView.swift
//  senes
//
//  Created by Konrad Cureau on 03/12/2021.
//

import SwiftUI

struct FriendsSegmentView: View {
    @ObservedObject var currentUser: CurrentUser
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(currentUser.friendsSorted, id: \.id) { friend in
                    NavigationLink(destination: ProfilOtherUserView(user: friend, currentUser: currentUser)) {
                        FriendProfilCell(friend: friend)
                    }.buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
        
        
    }
}

struct FriendsSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSegmentView(currentUser: CurrentUser())
    }
}
