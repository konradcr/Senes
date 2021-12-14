//
//  SenesApp.swift
//  Senes
//
//  Created by Konrad Cureau on 10/12/2021.
//

import SwiftUI

@main
struct SenesApp: App {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.greenAction
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.greenAction], for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.greenAction]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.greenAction]
        UITableView.appearance().backgroundColor = .white
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        UIPageControl.appearance().currentPageIndicatorTintColor = .greenAction
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.greenAction.withAlphaComponent(0.2)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
