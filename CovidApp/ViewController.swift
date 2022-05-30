//
//  ViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 29.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let colorOfTextField: UIColor? = UIColor(hex: 0xD9D9D9)
    private let btnColor: UIColor? = UIColor(hex: 0x6F6060)
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = colorOfTextField
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.attributedPlaceholder = NSAttributedString(
            string: "Имя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        return textField
    }()
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = colorOfTextField
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.attributedPlaceholder = NSAttributedString(
            string: "Возраст",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        return textField
    }()
    
    private lazy var radioBtn: UIButton = {
        let radioBtn = UIButton(type: .roundedRect)
        radioBtn.translatesAutoresizingMaskIntoConstraints = false
        radioBtn.backgroundColor = colorOfTextField
        radioBtn.layer.cornerRadius = 15
        radioBtn.setTitle("M", for: .normal)
        radioBtn.tintColor = .black
        return radioBtn
    }()
    
    private lazy var radioBtnTwo: UIButton = {
        let radioBtn = UIButton(type: .roundedRect)
        radioBtn.translatesAutoresizingMaskIntoConstraints = false
        radioBtn.backgroundColor = colorOfTextField
        radioBtn.layer.cornerRadius = 15
        radioBtn.setTitle("Ж", for: .normal)
        radioBtn.tintColor = .black
        return radioBtn
    }()
    
    private lazy var continueButton: UIButton = {
        let continueButton = UIButton()
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.backgroundColor = colorOfTextField
        continueButton.layer.cornerRadius = 21
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.backgroundColor = btnColor
        return continueButton
    }()
    

    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        self.view.addSubview(nameTextField)
        self.view.addSubview(ageTextField)
        self.view.addSubview(radioBtn)
        self.view.addSubview(radioBtnTwo)
        self.view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        
        let constraints = [
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 310),
            nameTextField.heightAnchor.constraint(equalToConstant: 35),
            
            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageTextField.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor, constant: 50),
            ageTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            ageTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            radioBtn.topAnchor.constraint(equalTo: ageTextField.bottomAnchor,constant: 20),
            radioBtn.leadingAnchor.constraint(equalTo: ageTextField.leadingAnchor),
            
            radioBtnTwo.topAnchor.constraint(equalTo: radioBtn.topAnchor),
            radioBtnTwo.leadingAnchor.constraint(equalTo: radioBtn.trailingAnchor, constant: 60),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 310),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
      
//Создаю расширение для UIColor, чтобы он принимал HEX кодировку (взял со stackoverflow)
extension UIColor {
       convenience init(red: Int, green: Int, blue: Int) {
           assert(red >= 0 && red <= 255, "Invalid red component")
           assert(green >= 0 && green <= 255, "Invalid green component")
           assert(blue >= 0 && blue <= 255, "Invalid blue component")

           self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
       }

       convenience init(hex: Int) {
           self.init(
               red: (hex >> 16) & 0xFF,
               green: (hex >> 8) & 0xFF,
               blue: hex & 0xFF
           )
       }
    }

