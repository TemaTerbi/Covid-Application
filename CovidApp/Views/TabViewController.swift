//
//  TabViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit
import SwiftUI

final class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let MainVC = MainViewController()
        let icon1 = UITabBarItem(title: "Главная", image: UIImage(systemName: "homekit"), tag: 0)
        MainVC.tabBarItem = icon1
        
        let profileTab = ProfileTab()
        let profile = UINavigationController(rootViewController: profileTab)
        let icon4 = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 1)
        profileTab.tabBarItem = icon4
        
        let swiftUiScreen = ContentView()
        let hostScreen = UIHostingController(rootView: swiftUiScreen)
        let icon3 = UITabBarItem(title: "Статистика", image: UIImage(systemName: "chart.bar.xaxis"), tag: 2)
        hostScreen.tabBarItem = icon3
        hostScreen.viewDidLoad()
        
        
        let controllers = [MainVC, hostScreen, profile]
        self.viewControllers = controllers
    }
}

