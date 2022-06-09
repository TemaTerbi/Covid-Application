//
//  MainViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit
import AudioToolbox

final class MainViewController: UIViewController {
    
    private let storage = UserDefaults.standard
    private var totalConfirmed = 0
    private var newCases = 0
    private let newCasesLabelColor = UIColor(hex: 0x7BB54E)
    private let imageColor = UIColor(hex: 0x25739F)
    
    
    private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = storage.string(forKey: "totalCases")
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var newCasesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = newCasesLabelColor
        label.text = "+" + (storage.string(forKey: "newCases") ?? "")
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
        let stackView = UIStackView(arrangedSubviews: [covidImage, totalLabel])
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
        let stackView = UIStackView(arrangedSubviews: [newCovid, newCasesLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("Обновить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = imageColor
        button.tintColor = .black
        button.addTarget(self, action: #selector(updateDataInLabelBtn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Helper Methotd
    @objc private func updateDataInLabelBtn() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        totalLabel.text = storage.string(forKey: "totalCases")
        newCasesLabel.text = "+" + storage.string(forKey: "newCases")!
        UIView.animate(withDuration: 0.3,
            animations: {
            self.updateButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.updateButton.transform = CGAffineTransform.identity
                }
            })
    }
    
    private func updateDataInLabel() {
        totalLabel.text = storage.string(forKey: "totalCases")
        newCasesLabel.text = "+" + (storage.string(forKey: "newCases") ?? "")
    }
    
    private func getResponseFromApiTotal() {
        ApiManager.shared.getTotal { globals in
            let storage = UserDefaults.standard
            self.totalConfirmed = (globals.global?.totalConfirmed)!
            storage.set(self.totalConfirmed, forKey: "totalCases")
        }
    }
    
    private func getResponseFromApiNewCases() {
        ApiManager.shared.getTotal { globals in
            let storage = UserDefaults.standard
            self.newCases = (globals.global?.newConfirmed)!
            storage.set(self.newCases, forKey: "newCases")
        }
    }
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getResponseFromApiTotal()
        getResponseFromApiNewCases()
        
        updateDataInLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

        addSubviews()
        setupConstraints()
        
        updateDataInLabel()
    }
    
    private func addSubviews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(totalInfoStackView)
        scrollView.addSubview(newCasesStackView)
        scrollView.addSubview(updateButton)
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
            
            updateButton.topAnchor.constraint(equalTo: newCasesStackView.bottomAnchor, constant: 10),
            updateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            updateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
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

