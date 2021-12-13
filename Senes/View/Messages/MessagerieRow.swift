//
//  MessagerieRow.swift
//  senes
//
//  Created by Apprenant 49 on 06/12/2021.
//

import SwiftUI

struct MessagerieRow: View {
    @Environment(\.dynamicTypeSize) var dynamicSize
    let chat: Chat
    
    var body: some View {
        HStack(spacing: 20) {
            Image(chat.person.profilPic)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .clipped()
            
            ZStack {
                VStack(alignment: .leading, spacing: 5) {
                    if dynamicSize > DynamicTypeSize.xLarge {
                        Group {
                            Text(chat.person.name)
                                .bold()
                            Text(chat.messages.last?.sentTime.descriptiveString() ?? "")
                            HStack {
                                Text(chat.messages.last?.text ?? "")
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                    .frame(height: 50, alignment: .top)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.trailing, 40)
                            }
                        }
                        .padding(.vertical)
                    } else {
                        HStack {
                            Text(chat.person.name)
                                .bold()
                            
                            Spacer()
                            
                            Text(chat.messages.last?.sentTime.descriptiveString() ?? "")
                        }
                        HStack {
                            Text(chat.messages.last?.text ?? "")
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .frame(height: 50, alignment: .top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 40)
                        }
                    }
                }
                
                Circle()
                    .foregroundColor(chat.hasUnreadMessage ? .blue : .clear)
                    .frame(width: 18, height: 18)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        //        .frame(height: 80)
    }
}

struct MessagerieRow_Previews: PreviewProvider {
    static var previews: some View {
        MessagerieRow(chat: Chat.sampleChat[2])
            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
