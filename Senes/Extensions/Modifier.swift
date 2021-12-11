//
//  Modifier.swift
//  senes
//
//  Created by Apprenant 73 on 02/12/2021.
//

import SwiftUI

struct ButtonPrincipalStyle: ViewModifier {
    let colorBck: Color
    let foregroundColor : Color
    let geo : GeometryProxy
    
    func body(content: Content) -> some View {
        content
            .frame(width: geo.size.width / 4, height: 50)
            .foregroundColor(foregroundColor)
            .background(colorBck)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 0)
            .padding(.bottom, 10.0)
        
    }
}
struct ButtonMediaStyle: ViewModifier {
    let backgroundColor: Color
    let foregroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

struct ButtonStyle: ViewModifier {
    let colorBck: Color
    let foregroundColor : Color
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(foregroundColor)
            .padding()
            .background(colorBck)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
    }
}
struct ModifierForTextView: ViewModifier {
    
    let geo: GeometryProxy
    func body(content: Content) -> some View {
        content
            .border(.gray, width: 2)
            .cornerRadius(4)
            .padding([.top, .leading, .trailing], 10.0)
            .frame(height: geo.size.height - 70)
        
    }
}
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
    }
}

struct ImageModifierWhitGeo: ViewModifier {
    
    let geo : GeometryProxy
    
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(maxWidth: geo.size.width / 6)
            .clipShape(Circle())
            .shadow(color: .gray, radius: 1, x: -3, y: 3)
    }
}

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 7.0)
            .scaledToFit()
    }
}

struct ImageModifierWithBackGround: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: 70, height: 70)
            .background(Color.greenAction)
            .clipShape(Circle())
            .foregroundColor(.white)
    }
}

struct InterestModifierImg : ViewModifier{
    let opacity : CGFloat
    let overlay : Color
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height:130)
            .overlay(overlay)
            .opacity(opacity)
            .cornerRadius(22)
            .padding(.trailing,12)
    }
}
extension View {
    func modifierForButonWithGeo(colorBck: Color,foregroundColor: Color, geo: GeometryProxy) -> some View {
        modifier(ButtonPrincipalStyle(colorBck: colorBck, foregroundColor: foregroundColor, geo: geo))
    }
    func buttonPrincipalStyle(colorBck: Color,foregroundColor: Color) -> some View {
        modifier(ButtonStyle(colorBck: colorBck, foregroundColor: foregroundColor))
    }
    func cardStyle() -> some View {
        modifier(CardModifier())
    }
    func buttonImportMediaStyle(backgroundColor: Color, foregroundColor: Color) -> some View {
        modifier(ButtonMediaStyle(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
    func modifierForImageWithGeo(geo: GeometryProxy) -> some View {
        modifier(ImageModifierWhitGeo(geo: geo))
    }
    
}



extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
