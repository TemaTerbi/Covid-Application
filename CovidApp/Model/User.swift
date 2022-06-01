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
}

class User: UserProtocol {
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
