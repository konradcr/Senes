//
//  CertificationView.swift
//  senes
//
//  Created by Konrad Cureau on 06/12/2021.
//

import SwiftUI

struct CertificationView: View {
    @ObservedObject var currentUser: CurrentUser
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isCertificationAsked = false

    var body: some View {
        NavigationView {
            VStack {
                if isCertificationAsked {
                    CertificationAsked()
                } else {
                    AskingCertificationView(currentUser: currentUser, isCertificationAsked: $isCertificationAsked)
                }
            }
            .padding()
            .navigationTitle("Certifie ton Profil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        dismiss()
                    }
                    .foregroundColor(.greenAction)
                }
            }
        }
    }
}

struct CertificationView_Previews: PreviewProvider {
    static var previews: some View {
        CertificationView(currentUser: CurrentUser())
    }
}
