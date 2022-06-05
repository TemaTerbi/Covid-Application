//
//  SceneDelegate.swift
//  CovidApp
//
//  Created by TeRb1 on 29.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let storage = UserDefaults.standard
    private var totalConfirmed: String = ""

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(scene: scene)
        if !storage.bool(forKey: "Login") {
            storage.set(false, forKey: "Login")
        }
    }
    
    
    //Создаем окно, которое у нас будет отображаться при запуске приложения
    private func setupWindow(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let controller = TabViewController()  //prod TabViewController()
        window?.rootViewController = controller
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}

