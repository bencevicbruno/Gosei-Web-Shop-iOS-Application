//
//  String+.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    static func random(length: Int = 10) -> Self {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
