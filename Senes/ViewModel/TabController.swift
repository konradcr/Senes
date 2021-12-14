//
//  TabControler.swift
//  Senes
//
//  Created by Konrad Cureau on 14/12/2021.
//

import Foundation

enum Tab {
    case community
    case activities
    case messages
    case profil
}

class TabController: ObservableObject {
    @Published var activeTab = Tab.community

    func open(_ tab: Tab) {
        activeTab = tab
    }
}
