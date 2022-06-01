//
//  test.swift
//  CovidApp
//
//  Created by TeRb1 on 01.06.2022.
//

import Foundation

protocol TestProtocol {
    var test: Bool { get set }
    
    mutating func change()
}

struct Test: TestProtocol {
    var test: Bool = false
    
    mutating func change() {
        self.test = true
    }
}
