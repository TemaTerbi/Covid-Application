//
//  User.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import Foundation

protocol UserProtocol {
    
    var name: String { get set }
    var age: Int { get set }
    var gender: String { get set }
}

final class User: UserProtocol {
    
    let storage = UserDefaults.standard
    
    var name: String
    var age: Int
    var gender: String
    
    init(name: String, age: Int, gender: String) {
        self.name = name
        self.age = age
        self.gender = gender
    }
    
    func saveFields() {
        storage.set(self.name, forKey: "Name")
        storage.set(self.age, forKey: "Age")
        storage.set(self.gender, forKey: "Gender")
    }
}

struct LoadUserData {
    let storage = UserDefaults.standard
    
    func loadUserData() -> (name: String, age: String, gender: String) {
        let name = storage.string(forKey: "Name")
        let age = String(storage.integer(forKey: "Age"))
        let gender = storage.string(forKey: "Gender")
        let tupleResult = (name ?? "",age,gender ?? "")
        return tupleResult
    }
}
