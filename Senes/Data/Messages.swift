//
//  Messages.swift
//  TestJson
//
//  Created by Konrad Cureau on 10/12/2021.
//

import Foundation

extension Chat {
    
    static let sampleChat = [
        
        Chat(id: "00ca62da-5992-11ec-bf63-0242ac130002", messages: [
            Message("Coucou Jeanine, ça va ?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("Oui et toi ? Tu fais quoi demain ?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("J'aimerais bien aller me balader.", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("Je préfererais faire de la couture. Ils annoncent du mauvais temps...", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message("Partante ?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message("Feu 🔥 ! Ca fait longtemps que je voulais bouger", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message("👌", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
            
        ]),
        
        Chat(id: "fc20a6d6-5991-11ec-bf63-0242ac130002", messages: [
            Message("La bonne journée ma belle Germaine", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 5)),
            Message("Je repense sans cesse à notre dernière balade. A quand la prochaine ? Les canards nous attendent 🦆🦆", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 5)),
            Message("Ha Ha Ha. Tu m'enchantes", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 4)),
            Message("Dès que possible, c'est vrai que nos conversations égayent mes journées. Que dis-tu de demain en fin de matinée ? Au même endroit que d'habitude", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("J'ai hâte d'y être ", type: .Sent, date: Date()),
        ]),

        
        Chat(id: "04e4d2ce-5992-11ec-bf63-0242ac130002", messages: [
            Message("Hey ça faisait longtemps, à quand un petit apéro sympa alors ?!", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 4)),
            Message("Mais quand tu veux Gégé, on se dit ce weekend ?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 4)),
            
        ]),
        
        Chat(id: "08548922-5992-11ec-bf63-0242ac130002", messages: [
            Message("Bonjour Vanessa, je te remercie encore pour la session shopping de l'autre jour, j'ai vraiment passé une agréable journée.", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 14)),
            Message("Plaisir partagé, on se refait ça quand tu veux 😘", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 14)),
            Message("Je suis disponible tous les jeudis et les vendredis. Si l'envie te prend, passe-moi un coup de fil et j'arrive", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 14)),
            Message("Je n'y manquerai pas, je te remercie ma mignonne", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 14)),
            
        ]),
        
    ]
}
