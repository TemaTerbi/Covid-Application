//
//  MainViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var storage = UserDefaults.standard
    
    private var mainBackgroundColor: UIColor? = UIColor(hex: 0x9A9696)
    
    override func viewDidAppear(_ animated: Bool) {
        print(storage.bool(forKey: "Login"))
        if storage.bool(forKey: "Login") == false {
            storage.set(true, forKey: "Login")
            let loginVC: ViewController = ViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.show(loginVC, sender: self)
        } else {
            return
        }
        print(storage.bool(forKey: "Login"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
    }
}
