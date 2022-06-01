//
//  ProfileTabViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit

class ProfileTabViewController: UIViewController {
    
    var storage = UserDefaults.standard
    
    lazy private var nameLable: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = storage.string(forKey: "Name")
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textAlignment = .center
        return lable
    }()
    
    lazy private var ageLable: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = storage.string(forKey: "Age")
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textAlignment = .center
        return lable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(nameLable)
        self.view.addSubview(ageLable)
    }
    
    private func setupConstraints() {
        
        let constraints = [
            nameLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLable.widthAnchor.constraint(equalToConstant: 310),
            nameLable.heightAnchor.constraint(equalToConstant: 35),
            
            ageLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageLable.centerYAnchor.constraint(equalTo: nameLable.centerYAnchor, constant: 30),
            ageLable.widthAnchor.constraint(equalToConstant: 310),
            ageLable.heightAnchor.constraint(equalToConstant: 35),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
