//
//  PersistenceData.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import Foundation

enum PersistenceData {
    
    enum Key: String {
        case user
        case language
        case color_scheme
    }
    
    struct User: Identifiable, Codable {
        var name: String
        var email: String
        var address: String?
        var phoneNumber: String?
        var birthday: Date?
        var avatarURL: URL?
        
        init(name: String, email: String, address: String? = nil, phoneNumber: String? = nil, birthday: Date? = nil, avatarURL: URL?) {
            self.name = name
            self.email = email
            self.address = address
            self.phoneNumber = phoneNumber
            self.birthday = birthday
            self.avatarURL = avatarURL
        }
        
        var id: String {
            return email
        }
        
        static var sample: User {
            .init(name: "hehe", email: "nono@idk.com", address: nil, phoneNumber: nil, birthday: nil, avatarURL: nil)
        }
    }
    
    enum Language: String, Identifiable, CaseIterable, Codable {
        case english = "en"
        case croatian = "hr"
        
        var id: Self {
            self
        }
        
        var name: String {
            "\(self)".capitalized
        }
    }
    
    enum ColorScheme: Identifiable, CaseIterable, Codable {
        case light
        case dark
        
        var id: Self {
            self
        }
    }
}
