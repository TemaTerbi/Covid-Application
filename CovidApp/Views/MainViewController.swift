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
    
    private lazy var counrtyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = imageColor
        label.text = storage.string(forKey: "countryName")
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var countryMonthCases: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = storage.string(forKey: "monthCounryCases")
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var covidImage: UIImageView = {
        let imageCovid = UIImage(systemName: "globe.asia.australia.fill")
        var image = UIImageView(image: imageCovid)
        image.contentMode = .scaleAspectFit
        image.setImageColor(color: imageColor)
        return image
    }()
    
    private lazy var newCovid: UIImageView = {
        let imageCovid = UIImage(systemName: "bandage.fill")
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
    
    private lazy var countryStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [counrtyLabel, countryMonthCases])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    //MARK: - Helper Methotd
    private func updateDataInLabel() {
        counrtyLabel.text = storage.string(forKey: "countryName")
    }
    
    private func getResponseFromApiTotal() {
        ApiManager.shared.getTotal { globals in
            let storage = UserDefaults.standard
            self.totalConfirmed = (globals.global?.totalConfirmed)!
            storage.set(self.totalConfirmed, forKey: "totalCases")
            DispatchQueue.main.async {
                self.totalLabel.text = self.storage.string(forKey: "totalCases")
            }
        }
    }
    
    private func getResponseFromApiNewCases() {
        ApiManager.shared.getTotal { globals in
            let storage = UserDefaults.standard
            self.newCases = (globals.global?.newConfirmed)!
            storage.set(self.newCases, forKey: "newCases")
            DispatchQueue.main.async {
                self.newCasesLabel.text = "+" + (self.storage.string(forKey: "newCases") ?? "")
            }
        }
    }
    
    private func loadResponseFromApiGetCountries() {
        ApiManager.shared.getCounries { countries in
            let sortedCountries = countries.sorted{$0.country ?? "" < $1.country ?? ""}
            DataService.shared.arrayCountries = sortedCountries
        }
    }
    
    private func loadResponseFromApiGetByCountry() {
        ApiManager.shared.getByCountry { country in
            var result = 0
            let allCases = country.map{$0.cases} 
            for el in allCases {
                result += el ?? 0
                let stringResult = String(result)
                UserDefaults.standard.set(stringResult, forKey: "monthCounryCases")
            }
            DispatchQueue.main.async {
                self.countryMonthCases.text = self.storage.string(forKey: "monthCounryCases")
            }
        }
    }
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadResponseFromApiGetByCountry()
        getResponseFromApiTotal()
        getResponseFromApiNewCases()
        loadResponseFromApiGetCountries()
        
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
        scrollView.addSubview(countryStack)
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
        
            countryStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            countryStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            countryStack.topAnchor.constraint(equalTo: newCasesStackView.bottomAnchor, constant: 10),
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

