//
//  AboutSegmentView.swift
//  senes
//
//  Created by Konrad Cureau on 03/12/2021.
//

import SwiftUI

struct AboutSegmentView: View {
    @ObservedObject var currentUser: CurrentUser
    
    var body: some View {
        VStack {
            Text(currentUser.description)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.white)
                .cardStyle()
                .padding()
            Spacer()
        }
        .padding(.vertical)
    }
}

struct AboutSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        AboutSegmentView(currentUser: CurrentUser())
    }
}
