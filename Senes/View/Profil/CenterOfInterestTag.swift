//
//  CenterOfInterestTag.swift
//  senes
//
//  Created by Konrad Cureau on 03/12/2021.
//

import SwiftUI

struct CenterOfInterestTag: View {
    let tag: CenterOfInterest
    
    var colorInterest: Color {
        switch tag {
        case .cuisine:
            return Color.red
        case .couture:
            return Color.orange
        case .arts:
            return Color.purple
        case .jardinage:
            return Color.red
        case .sport:
            return Color.blue
        case .literature:
            return Color.orange
        }
    }
    
    var body: some View {
        Text(tag.rawValue)
            .fontWeight(.semibold)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(colorInterest.opacity(0.7))
            .clipShape(Capsule())
    }
    
    
}

struct CenterOfInterestTag_Previews: PreviewProvider {
    static var previews: some View {
        CenterOfInterestTag(tag: .jardinage)
    }
}
