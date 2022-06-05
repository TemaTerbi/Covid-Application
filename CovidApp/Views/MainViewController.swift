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
    private var newCases: String = ""
    private let newCasesLabelColor: UIColor = UIColor(hex: 0x7BB54E)
    private let imageColor: UIColor = UIColor(hex: 0x25739F)
    
    
    private lazy var scrollView: UIScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
    
    private lazy var totalLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = totalConfirmed
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var newCasesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+" + newCases
        label.textColor = newCasesLabelColor
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var covidImage: UIImageView = {
        let imageCovid = UIImage(named: "covidImage")
        var image = UIImageView(image: imageCovid)
        image.contentMode = .scaleAspectFit
        image.setImageColor(color: imageColor)
        return image
    }()
    
    private lazy var newCovid: UIImageView = {
        let imageCovid = UIImage(named: "newMask")
        var image = UIImageView(image: imageCovid)
        image.contentMode = .scaleAspectFit
        image.setImageColor(color: imageColor)
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
    
    private lazy var newCasesStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [newCovid, newCasesLabel])
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
    private func getResponseFromApiTotal() {
        ApiManager.shared.getTotal { globals in
            let storage = UserDefaults.standard
            storage.set(globals.global?.totalConfirmed, forKey: "totalConfirmed")
        }
        totalConfirmed = String(storage.integer(forKey: "totalConfirmed"))
    }
    
    private func getResponseFromApiNewCases() {
        ApiManager.shared.getTotal { globals in
            let storage = UserDefaults.standard
            storage.set(globals.global?.newConfirmed, forKey: "newConfirmed")
        }
        newCases = String(storage.integer(forKey: "newConfirmed"))
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
        getResponseFromApiNewCases()
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
//        self.view.addSubview(totalInfoStackView)
//        self.view.addSubview(newCasesStackView)
        self.view.addSubview(scrollView)
        scrollView.addSubview(totalInfoStackView)
        scrollView.addSubview(newCasesStackView)

    }
    
    //MARK: - Private Methods
    private func setupConstraints() {
        
        let constraints = [
            totalInfoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            totalInfoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            totalInfoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            newCasesStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            newCasesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            newCasesStackView.topAnchor.constraint(equalTo: totalInfoStackView.bottomAnchor, constant: 10),
            
            covidImage.widthAnchor.constraint(equalToConstant: 80),
            covidImage.heightAnchor.constraint(equalToConstant: 80),
            
            newCovid.widthAnchor.constraint(equalToConstant: 80),
            newCovid.heightAnchor.constraint(equalToConstant: 80),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

//Расширение, чтобы можно было красить картинки
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

