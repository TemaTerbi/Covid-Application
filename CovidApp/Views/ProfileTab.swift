//
//  TestTableViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 17.06.2022.
//

import UIKit

class ProfileTab: UIViewController {
    
    private let tableView = UITableView.init(frame: .zero)
    private let user = LoadUserData().loadUserData()
    private let btnColor: UIColor = UIColor(hex: 0x6F6060)
    private let btnExit: UIColor = UIColor(hex: 0xF84A4A)
    private let storage = UserDefaults.standard
    
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
        button.layer.cornerRadius = 10
        button.setTitle("Изменить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = btnColor
        button.addTarget(self, action: #selector(changeInfo), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("Поиск", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = btnColor
        button.addTarget(self, action: #selector(showCountryTable), for: .touchUpInside)
        return button
    }()
    
    private lazy var pickerView: UIPickerView = {
        var picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .white
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    class TableViewCell: UITableViewCell {
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        tableView.backgroundColor = .systemGray5
        self.title = "Профиль"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = self
        
        addSubviews()
        setupConstraints()
        updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (contex) in
            self.updateLayout(with: size)
        }, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Private Methodts
    private func addSubviews() {
        self.view.addSubview(tableView)
        self.tableView.addSubview(nameLabel)
        self.tableView.addSubview(ageLable)
        self.tableView.addSubview(genderLable)
        self.tableView.addSubview(changeButton)
        self.tableView.addSubview(pickerView)
        self.tableView.addSubview(searchButton)
    }
    
    private func setupConstraints() {
        
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 35),
            
            ageLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            ageLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            ageLable.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            ageLable.heightAnchor.constraint(equalToConstant: 35),
            
            genderLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            genderLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            genderLable.topAnchor.constraint(equalTo: ageLable.bottomAnchor, constant: 5),
            genderLable.heightAnchor.constraint(equalToConstant: 35),
            
            changeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            changeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            changeButton.heightAnchor.constraint(equalToConstant: 40),
            
            pickerView.topAnchor.constraint(equalTo: genderLable.bottomAnchor, constant: 10),
            pickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            pickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            pickerView.heightAnchor.constraint(equalToConstant: 200),
            
            searchButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 10),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    @objc private func changeInfo() {
        showChangeAlert()
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.changeButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.changeButton.transform = CGAffineTransform.identity
            }
        })
    }
    
    @objc func showCountryTable() {
        let countryTable = CountryTableViewController()
        show(countryTable, sender: self)
    }
//
    @objc private func showChangeAlert() {
        let alertController = UIAlertController(title: "Измненеие данных", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Имя"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Возраст"
            textField.keyboardType = .numberPad
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak alertController] _ in
            guard let textFields = alertController?.textFields else { return }
            
            if let nameText = textFields[0].text,
               let ageText = textFields[1].text {
                guard nameText.isEmpty else {
                    self.storage.set(nameText, forKey: "Name")
                    DispatchQueue.main.async {
                        self.nameLabel.text = self.storage.string(forKey: "Name")
                    }
                    guard ageText.isEmpty else {
                        if let age = Int(ageText) {
                            if age <= 101 {
                                self.storage.set(age, forKey: "Age")
                            } else {
                                let alertController = UIAlertController(
                                    title: "Ошибка!",
                                    message: "Возраст не может быть больше 101!",
                                    preferredStyle: .alert)
                                let btnRepeat = UIAlertAction(title: "Повторить", style: .default)
                                alertController.addAction(btnRepeat)
                                self.present(alertController, animated: true)
                            }
                        } else {
                            let alertController = UIAlertController(
                                title: "Ошибка!",
                                message: "Вы ввели не корректный возраст",
                                preferredStyle: .alert)
                            let btnRepeat = UIAlertAction(title: "Повторить", style: .default)
                            alertController.addAction(btnRepeat)
                            self.present(alertController, animated: true)
                        }
                        DispatchQueue.main.async {
                            self.ageLable.text = self.storage.string(forKey: "Age")
                        }
                        return
                    }
                    return
                }
                guard ageText.isEmpty else {
                    if let age = Int(ageText) {
                        if age <= 101 {
                            self.storage.set(age, forKey: "Age")
                        } else {
                            let alertController = UIAlertController(
                                title: "Ошибка!",
                                message: "Возраст не может быть больше 101!",
                                preferredStyle: .alert)
                            let btnRepeat = UIAlertAction(title: "Повторить", style: .default)
                            alertController.addAction(btnRepeat)
                            self.present(alertController, animated: true)
                        }
                    } else {
                        let alertController = UIAlertController(
                            title: "Ошибка!",
                            message: "Вы ввели не корректный возраст",
                            preferredStyle: .alert)
                        let btnRepeat = UIAlertAction(title: "Повторить", style: .default)
                        alertController.addAction(btnRepeat)
                        self.present(alertController, animated: true)
                    }
                    DispatchQueue.main.async {
                        self.ageLable.text = self.storage.string(forKey: "Age")
                    }
                    return
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

//MARK: - Extension
extension ProfileTab: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = "Test cells"
        return cell
    }
}

//delegate for picker view
extension ProfileTab: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataService.shared.arrayCountries.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataService.shared.arrayCountries[row].country
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedIso = DataService.shared.arrayCountries[row].iso2
        let selectedName = DataService.shared.arrayCountries[row].country
        UserDefaults.standard.set(selectedIso, forKey: "selectIso")
        UserDefaults.standard.set(selectedName, forKey: "countryName")
        DataService.shared.boolLoop = true
        DataService.shared.items = []
    }
}

