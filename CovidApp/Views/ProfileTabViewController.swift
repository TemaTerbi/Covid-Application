//
//  ProfileTabViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit

class ProfileTabViewController: UIViewController {
    
    private let btnColor: UIColor? = UIColor(hex: 0x6F6060)
    private let btnExit: UIColor? = UIColor(hex: 0xF84A4A)
    
    private var storage = UserDefaults.standard
    
    lazy private var nameLable: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = storage.string(forKey: "Name")
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.textAlignment = .center
        lable.backgroundColor = .white
        lable.layer.masksToBounds = true
        lable.layer.cornerRadius = 10
        return lable
    }()
    
    lazy private var ageLable: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = storage.string(forKey: "Age")
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.textAlignment = .center
        lable.backgroundColor = .white
        lable.layer.masksToBounds = true
        lable.layer.cornerRadius = 10
        return lable
    }()
    
    lazy private var genderLable: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = storage.string(forKey: "Gender")
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.textAlignment = .center
        lable.backgroundColor = .white
        lable.layer.masksToBounds = true
        lable.layer.cornerRadius = 10
        return lable
    }()
    
    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 21
        button.setTitle("Изменить", for: .normal)
        button.backgroundColor = btnColor
//        button.addTarget(self, action: #selector(showMainScreen), for: .touchUpInside)
        return button
    }()
    
    private lazy var anotherAccount: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 21
        button.setTitle("Войти в другой аккаунт", for: .normal)
        button.backgroundColor = btnExit
//        button.addTarget(self, action: #selector(showMainScreen), for: .touchUpInside)
        return button
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(nameLable)
        self.view.addSubview(ageLable)
        self.view.addSubview(genderLable)
        self.view.addSubview(changeButton)
        self.view.addSubview(anotherAccount)
    }
    
    //MARK: - Private Methods
    private func setupConstraints() {
        
        let constraints = [
            nameLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLable.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLable.widthAnchor.constraint(equalToConstant: 310),
            nameLable.heightAnchor.constraint(equalToConstant: 35),
            
            ageLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageLable.centerYAnchor.constraint(equalTo: nameLable.centerYAnchor, constant: 40),
            ageLable.widthAnchor.constraint(equalToConstant: 310),
            ageLable.heightAnchor.constraint(equalToConstant: 35),
            
            genderLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderLable.centerYAnchor.constraint(equalTo: ageLable.centerYAnchor, constant: 40),
            genderLable.widthAnchor.constraint(equalToConstant: 310),
            genderLable.heightAnchor.constraint(equalToConstant: 35),
            
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            changeButton.widthAnchor.constraint(equalToConstant: 310),
            changeButton.heightAnchor.constraint(equalToConstant: 40),
            
            anotherAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            anotherAccount.bottomAnchor.constraint(equalTo: changeButton.topAnchor, constant: -5),
            anotherAccount.widthAnchor.constraint(equalToConstant: 310),
            anotherAccount.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
