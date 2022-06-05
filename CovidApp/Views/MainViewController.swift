//
//  MainViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let storage = UserDefaults.standard
    private var totalConfirmed: String = ""
    
    private lazy var totalLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = totalConfirmed
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var covidImage: UIImageView = {
        let imageCovid = UIImage(named: "covidImage")
        var image = UIImageView(image: imageCovid)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var totalInfoStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [covidImage, totalLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    //MARK: - Helper Methotd 
    func getResponseFromApiTotal() {
        ApiManager.shared.getTotal { globals in
            let storage = UserDefaults.standard
            storage.set(globals.global?.totalConfirmed, forKey: "totalConfirmed")
        }
        totalConfirmed = String(storage.integer(forKey: "totalConfirmed"))
    }
    
    
    //MARK: - Life cycle
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        getResponseFromApiTotal()
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(totalLabel)
        self.view.addSubview(totalInfoStackView)
    }
    
    //MARK: - Private Methods
    private func setupConstraints() {
        
        let constraints = [
            totalInfoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            totalInfoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            totalInfoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            covidImage.widthAnchor.constraint(equalToConstant: 80),
            covidImage.heightAnchor.constraint(equalToConstant: 80),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}

