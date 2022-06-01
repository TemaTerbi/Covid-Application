//
//  MainViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var lll = Test()
    private var mainBackgroundColor: UIColor? = UIColor(hex: 0x9A9696)
    
//    override func viewDidAppear(_ animated: Bool) {
//        if lll.test == false {
//            let loginVC: ViewController = ViewController()
//            loginVC.modalPresentationStyle = .fullScreen
//            self.show(loginVC, sender: self)
//            print(lll.test)
//        }
//        lll.change()
//        print(lll.test)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
    }
}

