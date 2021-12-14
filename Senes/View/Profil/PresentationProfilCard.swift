//
//  PresentationProfilCard.swift
//  senes
//
//  Created by Konrad Cureau on 03/12/2021.
//

import SwiftUI

struct PresentationProfilCard: View {
    @Environment(\.sizeCategory) var sizeCategory
    @ObservedObject var currentUser: CurrentUser
    
    var body: some View {
        if sizeCategory > ContentSizeCategory.large {
            VStack(alignment: .center) {
                HStack {
                    Image(currentUser.profilPic)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 140)
                        .shadow(radius: 7)
                    VStack {
                        Image(systemName: currentUser.isCertified ? "checkmark.seal.fill" : "xmark.seal.fill")
                            .foregroundColor(currentUser.isCertified ? Color.greenAction : .gray)
                        Text(currentUser.name)
                            .bold()
                            .font(.title)
                        Text(currentUser.city)
                            .font(.title2)
                    }
                }
                
                
                ForEach(currentUser.centersOfInterest, id:\.self) { interest in
                    CenterOfInterestTag(tag: interest)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.white)
            .cardStyle()
            .padding(.vertical)
        } else {
            HStack {
                Image(currentUser.profilPic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 140)
                    .shadow(radius: 7)
                    .padding()
                
                VStack (alignment: .leading){
                    HStack {
                        Text(currentUser.name)
                            .bold()
                        Spacer()
                        Image(systemName: currentUser.isCertified ? "checkmark.seal.fill" : "xmark.seal.fill")
                            .foregroundColor(currentUser.isCertified ? Color.greenAction : .gray)
                    }
                    .font(.title)
                    Text(currentUser.city)
                        .font(.title2)
                    
                    HStack {
                        ForEach(currentUser.centersOfInterest, id:\.self) { interest in
                            CenterOfInterestTag(tag: interest)
                            
                        }
                    }
                    
                }
                .padding(.trailing, 20)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.white)
            .cardStyle()
            .padding(.vertical)
        }
        
    }
}

struct PresentationProfilCard_Previews: PreviewProvider {
    static var previews: some View {
        PresentationProfilCard(currentUser: CurrentUser())
            .background(.gray)
            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
        
    }
}
