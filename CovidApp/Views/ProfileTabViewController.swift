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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = btnColor
        button.addTarget(self, action: #selector(changeInfo), for: .touchUpInside)
        return button
    }()
    
//    private lazy var anotherAccount: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 21
//        button.setTitle("Войти в другой аккаунт", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
//        button.backgroundColor = btnExit
//        button.addTarget(self, action: #selector(enterInAnotherAccount), for: .touchUpInside)
//        return button
//    }()
    
    lazy private var header: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Профиль"
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lable.textAlignment = .left
        return lable
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.largeContentTitle = "dsdsd"
        view.backgroundColor = .systemGray5
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(nameLable)
        self.view.addSubview(ageLable)
        self.view.addSubview(genderLable)
        self.view.addSubview(changeButton)
//        self.view.addSubview(anotherAccount)
        self.view.addSubview(header)
    }
    
    //MARK: - Private Methods
    private func setupConstraints() {
        
        let constraints = [
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLable.centerYAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            nameLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLable.heightAnchor.constraint(equalToConstant: 35),
            
            ageLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageLable.centerYAnchor.constraint(equalTo: nameLable.centerYAnchor, constant: 40),
            ageLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            ageLable.heightAnchor.constraint(equalToConstant: 35),
            
            genderLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderLable.centerYAnchor.constraint(equalTo: ageLable.centerYAnchor, constant: 40),
            genderLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            genderLable.heightAnchor.constraint(equalToConstant: 35),
            
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            changeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            changeButton.heightAnchor.constraint(equalToConstant: 40),
            
//            anotherAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            anotherAccount.bottomAnchor.constraint(equalTo: changeButton.topAnchor, constant: -5),
//            anotherAccount.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            anotherAccount.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func changeInfo() {
        let loginVC: ViewController = ViewController()
        self.show(loginVC, sender: self)
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
