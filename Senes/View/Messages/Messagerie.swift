//
//  Messagerie.swift
//  senes
//
//  Created by Apprenant 49 on 01/12/2021.
//

import SwiftUI

struct Messagerie: View {
    @StateObject var viewModel = MessagerieViewModel()
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getSortedFilteredChats(query: query)) { chat in
                    
                    ZStack {
                        
                        MessagerieRow(chat: chat)
                        
                    NavigationLink(destination: {
                       MessagerieView(chat: chat)
                            .environmentObject(viewModel)
                    }) {
                       EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 0)
                    .opacity(0)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(action: {
                            viewModel.markAsUnread(!chat.hasUnreadMessage, chat: chat)
                        }) {
                            if chat.hasUnreadMessage {
                                Label("Read", systemImage: "text.bubble")
                            } else {
                                Label("Unread", systemImage: "circle.fill")
                            }
                        }
                        .tint(.blue)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $query)
            .navigationTitle("Messagerie")
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "square.and.pencil")
                })
        }
    }
}
struct Messsagerie_Previews: PreviewProvider {
    static var previews: some View {
        Messagerie()
    }
}
