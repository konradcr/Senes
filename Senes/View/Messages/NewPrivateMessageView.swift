//
//  NewPrivateMessageView.swift
//  Senes
//
//  Created by Konrad Cureau on 15/12/2021.
//

import SwiftUI

struct NewPrivateMessageView: View {
    @EnvironmentObject var viewModel: MessagerieViewModel
    @ObservedObject var currentUser: CurrentUser
    @State private var contactSearch: String = ""
    @State private var friendSelected: Person?
    @State private var text = ""
    @FocusState private var isFocused
    
    @Binding var isWritingNewMessage: Bool
    
    var filteredUsers: [Person] {
        if contactSearch == "" { return currentUser.friends }
        return currentUser.friends.filter {
            $0.name.lowercased().contains(contactSearch.lowercased())
        }
    }

    var body: some View {
        NavigationView {
            
            VStack {
                HStack {
                    Text("À :")
                    if let friend = friendSelected {
                        Text(friend.name)
                        Spacer()
                    } else  {
                        TextField("", text: $contactSearch)
                    }
                    Menu {
                        ForEach(currentUser.friends, id:\.id) { friend in
                            Button(friend.name) {
                                self.friendSelected = friend
                            }
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }.padding()
                Divider()
                
                if contactSearch != "" {
                    List(filteredUsers) { resultUser in
                        Text(resultUser.name)
                    }
                }
                Spacer()
                toolbarView()
                
            }
            
            .navigationTitle("Nouveau Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isWritingNewMessage = false
                    } label: {
                        Text("Annuler")
                    }

                }
            }
        
            
        }
        
    }
    
    func toolbarView() -> some View {
                    VStack {
                        let height: CGFloat = 37
                        HStack {
                            TextField("Message ...", text: $text)
                                .padding(.horizontal, 10)
                                .frame(height: height)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 13))
                                .focused($isFocused)

                            Button(action: {}) {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.white)
                                    .frame(width: height, height: height)
                                  .background(
                                     Circle()
                                        .foregroundColor(text.isEmpty ? (Color(UIColor(named:"VertClair")!)) : .blue)
                                  )
                            }
                            .disabled(text.isEmpty)

                        }.padding(.vertical)
                            .padding(.horizontal)
                            .background(.thickMaterial)

                    }
                }
}

struct NewPrivateMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewPrivateMessageView(currentUser: CurrentUser(), isWritingNewMessage: .constant(true))
    }
}
