//
//  MyProfilView.swift
//  senes
//
//  Created by Konrad Cureau on 03/12/2021.
//

import SwiftUI

struct MyProfilView: View {
    @ObservedObject var currentUser: CurrentUser

    @State private var isCertificationPresented: Bool = false
    
    enum SegmentedProfile: String, CaseIterable {
        case about = "À Propos"
        case activities = "Activités"
        case friends = "Amis"
    }
    
    @State private var segmentedProfile: SegmentedProfile = .about
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    PresentationProfilCard(currentUser: currentUser)
                    Picker("What is your favorite color?", selection: $segmentedProfile) {
                        ForEach(SegmentedProfile.allCases, id: \.self) { segment in
                            Text(segment.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                .padding(.horizontal)
                
                switch segmentedProfile {
                case .about:
                    AboutSegmentView(currentUser: currentUser)
                case .activities:
                    ActivitiesSegmentView(currentUser: currentUser)
                case .friends:
                    FriendsSegmentView(currentUser: currentUser)
                }
                
            }
            .navigationTitle("Mon Profil")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isCertificationPresented.toggle()
                    } label: {
                        Image(systemName: "lock.shield")
                    }
                }
            }
        }
        .sheet(isPresented: $isCertificationPresented) {
            CertificationView(currentUser: currentUser)
        }
    }
}

struct MyProfilView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfilView(currentUser: CurrentUser())
            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
