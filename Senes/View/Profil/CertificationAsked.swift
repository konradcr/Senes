//
//  CertificationAsked.swift
//  senes
//
//  Created by Konrad Cureau on 07/12/2021.
//

import SwiftUI

struct CertificationAsked: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 200))
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(.gray)
            Text("Ta demande de certification a bien été soumise ! \n Tu recevras une réponse dans un délai de 2 semaines.")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct CertificationAsked_Previews: PreviewProvider {
    static var previews: some View {
        CertificationAsked()
    }
}
