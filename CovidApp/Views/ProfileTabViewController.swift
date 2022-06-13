//
//  ProfileTabViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import UIKit
import AudioToolbox

final class ProfileTabViewController: UIViewController {
    
    private let user = LoadUserData().loadUserData()
    private let btnColor: UIColor = UIColor(hex: 0x6F6060)
    private let btnExit: UIColor = UIColor(hex: 0xF84A4A)
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = user.name
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    private lazy var ageLable: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = user.age
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    private lazy var genderLable: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = user.gender
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
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
    
    private lazy var selectCountry: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 21
        button.setTitle("Выбрать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = btnColor
        button.addTarget(self, action: #selector(selectCountryBtn), for: .touchUpInside)
        return button
    }()
    
    private lazy var header: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Профиль"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var pickerView: UIPickerView = {
        var picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .white
        picker.layer.cornerRadius = 10
        return picker
    }()
    

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        addSubviews()
        setupConstraints()
        pickerView.delegate = self
    }
    
    private func addSubviews() {
        self.view.addSubview(nameLabel)
        self.view.addSubview(ageLable)
        self.view.addSubview(genderLable)
        self.view.addSubview(changeButton)
        self.view.addSubview(header)
        self.view.addSubview(pickerView)
        self.view.addSubview(selectCountry)
    }
    
    //MARK: - Private Methods
    private func setupConstraints() {
        
        let constraints = [
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 35),
            
            ageLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageLable.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 40),
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
            
            pickerView.topAnchor.constraint(equalTo: genderLable.bottomAnchor, constant: 10),
            pickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            pickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            pickerView.heightAnchor.constraint(equalToConstant: 200),
            
            selectCountry.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectCountry.bottomAnchor.constraint(equalTo: changeButton.topAnchor, constant: -5),
            selectCountry.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            selectCountry.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func selectCountryBtn() {
        let indexOfCountry = pickerView.selectedRow(inComponent: 0)
        let selectedIso = DataService.shared.arrayCountries[indexOfCountry].iso2
        let selectedName = DataService.shared.arrayCountries[indexOfCountry].country
        UserDefaults.standard.set(selectedIso, forKey: "selectIso")
        UserDefaults.standard.set(selectedName, forKey: "countryName")
        UIView.animate(withDuration: 0.3,
            animations: {
            self.selectCountry.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.selectCountry.transform = CGAffineTransform.identity
                }
            })
    }
    
    @objc private func changeInfo() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        let loginVC: ViewController = ViewController()
        self.show(loginVC, sender: self)
        UIView.animate(withDuration: 0.3,
            animations: {
            self.changeButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.changeButton.transform = CGAffineTransform.identity
                }
            })
    }
}

//delegate for picker view
extension ProfileTabViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataService.shared.arrayCountries.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataService.shared.arrayCountries[row].country
    }
}
