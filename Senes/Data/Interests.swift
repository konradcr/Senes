//
//  Interests.swift
//  TestJson
//
//  Created by Konrad Cureau on 10/12/2021.
//

import Foundation

extension Interest{
    static var art : Interest = Interest(category: .arts, catImage: "arts")
    static var jardinage: Interest = Interest(category: .jardinage, catImage: "jardinage")
    static var litterature : Interest = Interest(category: .literature, catImage: "litterature")
    static var sport : Interest = Interest(category: .sport, catImage: "sport")
    static var cuisine : Interest = Interest(category: .cuisine, catImage: "cuisine")
    static var couture: Interest = Interest(category: .couture, catImage: "couture")
    
    static var interests : [Interest]{
        [art,jardinage,litterature,sport,cuisine,couture]
    }
}
