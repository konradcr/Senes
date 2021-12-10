//
//  Interests.swift
//  TestJson
//
//  Created by Konrad Cureau on 10/12/2021.
//

import Foundation

extension Interest{
    static var art : Interest = Interest(category: .arts, catImage: "interest-6")
    static var jardinage: Interest = Interest(category: .jardinage, catImage: "interest-1")
    static var littérature : Interest = Interest(category: .literature, catImage: "interest-3")
    static var sport : Interest = Interest(category: .sport, catImage: "interest-4")
    static var cuisine : Interest = Interest(category: .cuisine, catImage: "interest-5")
    static var couture: Interest = Interest(category: .couture, catImage: "interest-2")
    
    static var interests : [Interest]{
        [art,jardinage,littérature,sport,cuisine,couture]
    }
}
