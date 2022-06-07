//
//  ViewController.swift
//  CovidApp
//
//  Created by TeRb1 on 29.05.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    private let colorOfTextField: UIColor = UIColor(hex: 0xD9D9D9)
    private let btnColor: UIColor = UIColor(hex: 0x6F6060)
    private let radioButtonIsSelecredColor: UIColor? = UIColor(hex: 0xB8FFBF)
    
    lazy var nameTextField: UITextField = {
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
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var radioBtn: UIButton = {
        let radioBtn = UIButton(type: .roundedRect)
        radioBtn.translatesAutoresizingMaskIntoConstraints = false
        radioBtn.backgroundColor = colorOfTextField
        radioBtn.layer.cornerRadius = 15
        radioBtn.addTarget(self, action: #selector(maleTapRadioButton), for: .touchUpInside)
        radioBtn.tintColor = radioButtonIsSelecredColor
        return radioBtn
    }()
    
    private lazy var radioBtnTwo: UIButton = {
        let radioBtn = UIButton(type: .roundedRect)
        radioBtn.translatesAutoresizingMaskIntoConstraints = false
        radioBtn.backgroundColor = colorOfTextField
        radioBtn.layer.cornerRadius = 15
        radioBtn.addTarget(self, action: #selector(feMaleTapRadioButton), for: .touchUpInside)
        radioBtn.tintColor = radioButtonIsSelecredColor
        radioBtn.tintAdjustmentMode = .normal
        return radioBtn
    }()
    
    private lazy var continueButton: UIButton = {
        let continueButton = UIButton()
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.layer.cornerRadius = 21
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        continueButton.backgroundColor = btnColor
        continueButton.addTarget(self, action: #selector(showMainScreen), for: .touchUpInside)
        return continueButton
    }()
    
    private lazy var maleText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "M"
        text.font = UIFont.systemFont(ofSize: 14)
        text.textAlignment = .center
        return text
    }()
    
    private lazy var feMaleText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Ж"
        text.font = UIFont.systemFont(ofSize: 14)
        text.textAlignment = .center
        return text
    }()
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nameTextField.delegate = self
        ageTextField.delegate = self
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
        self.view.addSubview(maleText)
        self.view.addSubview(feMaleText)
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
            radioBtn.widthAnchor.constraint(equalToConstant: 30),
            radioBtn.heightAnchor.constraint(equalToConstant: 30),
            
            radioBtnTwo.topAnchor.constraint(equalTo: radioBtn.topAnchor),
            radioBtnTwo.leadingAnchor.constraint(equalTo: radioBtn.trailingAnchor, constant: 60),
            radioBtnTwo.widthAnchor.constraint(equalTo: radioBtn.widthAnchor),
            radioBtnTwo.heightAnchor.constraint(equalTo: radioBtn.heightAnchor),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 310),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            
            maleText.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 28),
            maleText.leadingAnchor.constraint(equalTo: radioBtn.trailingAnchor, constant: 20),
            maleText.widthAnchor.constraint(equalToConstant: 15),
            maleText.heightAnchor.constraint(equalToConstant: 15),
            
            feMaleText.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 28),
            feMaleText.leadingAnchor.constraint(equalTo: radioBtnTwo.trailingAnchor, constant: 20),
            feMaleText.widthAnchor.constraint(equalToConstant: 15),
            feMaleText.heightAnchor.constraint(equalToConstant: 15),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    //MARK: - Helper Methods
    
    @objc private func maleTapRadioButton(sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            radioBtnTwo.isSelected = false
        } else {
            sender.isSelected = true
            radioBtnTwo.isSelected = false
        }
    }
    
    @objc private func feMaleTapRadioButton(sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            radioBtn.isSelected = false
        } else {
            sender.isSelected = true
            radioBtn.isSelected = false
        }
    }
    
    private func validationIsEmpty(firstField: String, secondField: String) {
        if firstField.isEmpty {
            let alertController = UIAlertController(
                title: "Ошибка!",
                message: "Вы не ввели имя!",
                preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Повторить", style: .default)
            alertController.addAction(btnOk)
            self.present(alertController, animated: true)
            return
        }
        
        if secondField.isEmpty {
            let alertController = UIAlertController(
                title: "Ошибка!",
                message: "Вы не ввели возраст!",
                preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Повторить", style: .default)
            alertController.addAction(btnOk)
            self.present(alertController, animated: true)
            return
        }
    }
    
    private func checkGenderSelect() {
        if !radioBtn.isSelected && !radioBtnTwo.isSelected {
            let alertController = UIAlertController(
                title: "Ошибка!",
                message: "Выберите пол",
                preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Повторить", style: .default)
            alertController.addAction(btnOk)
            self.present(alertController, animated: true)
            return
        }
    }
    
    private func validationAgeField(field: String) -> Int {
        var ageNum = 0
        if let age = Int(field) {
            ageNum = age
        } else {
            let alertController = UIAlertController(
                title: "Ошибка!",
                message: "Вы ввели не корректный возраст",
                preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Повторить", style: .default)
            alertController.addAction(btnOk)
            self.present(alertController, animated: true)
        }
        return ageNum
    }
    
    private func whichGenderSelected() -> String {
        var gender = ""
        if radioBtn.isSelected {
            gender = "Муж."
        } else if radioBtnTwo.isSelected {
            gender = "Жен."
        }
        return gender
    }
    
    private func loginInApp() {
        let nameField = nameTextField.text!
        let ageField = ageTextField.text!
        validationIsEmpty(firstField: nameField, secondField: ageField)
        let age = validationAgeField(field: ageField)
        checkGenderSelect()
        let gender = whichGenderSelected()
        let user = User(name: nameField, age: age, gender: gender)
        let test = ProfileTabViewController()
        test.user = user
//        user.saveFields()
    }
    
    @objc private func showMainScreen(sender: UIButton) {
        loginInApp()
        let mainViewController = TabViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        self.show(mainViewController, sender: self)
    }
}

//Делегаты скрытия клавиатуры с экрана по тапу на экран и по кнопке return переход к следующему textfield
extension ViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
        
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ageTextField.becomeFirstResponder()
        return true
    }
}
      
//Создаю расширение для UIColor, чтобы он принимал HEX кодировку (взял со stackoverflow)
extension UIColor {
       convenience init(red: Int, green: Int, blue: Int) {
           assert(red >= 0 && red <= 255, "Некорректный красный цвет")
           assert(green >= 0 && green <= 255, "Некорректный зеленый цвет")
           assert(blue >= 0 && blue <= 255, "Некорректный синий цвет")

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

