//
//  MainViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let storage = UserDefaults.standard
    var apiManager = ApiManager()
    private var totalConfirmed: String = ""
    
    private lazy var totalLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = totalConfirmed
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    //MARK: - Helper Methodt
    private func getResponseFromApiTotal() {
        apiManager.getTotal { global in
            let storage = UserDefaults.standard
            storage.set(global.global?.totalConfirmed, forKey: "totalConfirmed")
        }
        totalConfirmed = String(storage.integer(forKey: "totalConfirmed"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if storage.bool(forKey: "Login") == false {
            storage.set(true, forKey: "Login")
            let loginVC: ViewController = ViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.show(loginVC, sender: self)
        } else {
            return
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        getResponseFromApiTotal()
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(totalLabel)
    }
    
    //MARK: - Private Methods
    private func setupConstraints() {
        
        let constraints = [
            totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            totalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            totalLabel.heightAnchor.constraint(equalToConstant: 35),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}

