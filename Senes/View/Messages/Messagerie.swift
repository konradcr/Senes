//
//  Messagerie.swift
//  senes
//
//  Created by Apprenant 49 on 01/12/2021.
//

import SwiftUI

struct Messagerie: View {
    @StateObject var viewModel = MessagerieViewModel()
    @ObservedObject var currentUser: CurrentUser
    @State private var query = ""
    @State private var isWritingNewMessage: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getSortedFilteredChats(query: query)) { chat in
                    
                    ZStack {
                        
                        MessagerieRow(chat: chat)
                        
                    NavigationLink(destination: {
                        MessagerieView(currentUser: currentUser, chat: chat)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isWritingNewMessage = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $isWritingNewMessage) {
                NewPrivateMessageView(currentUser: currentUser, isWritingNewMessage: $isWritingNewMessage)
                    .environmentObject(viewModel)
            }
        }
    }
}
struct Messsagerie_Previews: PreviewProvider {
    static var previews: some View {
        Messagerie(currentUser: CurrentUser())
    }
}
