//
//  FriendProfilCell.swift
//  senes
//
//  Created by Konrad Cureau on 03/12/2021.
//

import SwiftUI

struct FriendProfilCell: View {
    let friend: Person
    
    var body: some View {
        VStack {
            Image(friend.profilPic)
                .resizable()
                .clipShape(Circle())
                .frame(width: 90, height: 90)
                .shadow(radius: 7)
            Text(friend.name)
        }
        .padding()
    }
}

struct FriendProfilCell_Previews: PreviewProvider {
    static var users: [Person] = Bundle.main.decode([Person].self, from: "users.json")

    static var previews: some View {
        FriendProfilCell(friend: users[0])
    }
}
