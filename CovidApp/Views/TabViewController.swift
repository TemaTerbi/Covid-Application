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
        let icon1 = UITabBarItem(title: "Главная", image: UIImage(named: "HomeTab"), tag: 0)
        MainVC.tabBarItem = icon1
        
        let ProfileVC = ProfileTabViewController()
        let icon2 = UITabBarItem(title: "Профиль", image: UIImage(named: "user"), tag: 1)
        ProfileVC.tabBarItem = icon2
        
        let testVc = TestTableViewController()
        let navVC = UINavigationController(rootViewController: testVc)
        let icon4 = UITabBarItem(title: "Тест", image: UIImage(named: "user"), tag: 1)
        testVc.tabBarItem = icon4
        
        let swiftUiScreen = ContentView()
        let hostScreen = UIHostingController(rootView: swiftUiScreen)
        let icon3 = UITabBarItem(title: "Статистика", image: UIImage(named: "stat"), tag: 2)
        hostScreen.tabBarItem = icon3
        hostScreen.viewDidLoad()
        
        
        let controllers = [MainVC, hostScreen, ProfileVC, navVC]
        self.viewControllers = controllers
    }
}

