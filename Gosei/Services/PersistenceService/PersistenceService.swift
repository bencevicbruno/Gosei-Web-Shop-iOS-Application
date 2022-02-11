//
//  PersistenceService.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import Foundation
import UIKit

final class PersistenceService: PersistenceServiceProtocol {
    
    var user: PersistenceData.User? {
        get {
            return UserDefaults.load(key: .user)
        }
        set {
            UserDefaults.save(newValue, key: .user)
        }
    }
    
    var langauge: PersistenceData.Language? {
        get {
            return UserDefaults.load(key: .language)
        }
        set {
            UserDefaults.save(newValue, key: .language)
        }
    }
    
    var colorScheme: PersistenceData.ColorScheme {
        get {
            return UserDefaults.load(key: .color_scheme) ?? .light
        }
        set {
            UIApplication.shared.statusBarStyle = newValue == .light ? .lightContent : .darkContent
            UserDefaults.save(newValue, key: .color_scheme)
        }
    }
    
    var useLightMode: Bool {
        colorScheme == .light
    }
    
    var useDarkMode: Bool {
        colorScheme == .dark
    }
}
