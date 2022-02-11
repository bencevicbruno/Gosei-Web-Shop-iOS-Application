//
//  Color+.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.11.2021..
//

import SwiftUI
import Fusion

extension Color {
    @Inject fileprivate static var persistenceService: PersistenceServiceProtocol
    
    fileprivate static var lightMode: Bool {
        persistenceService.useLightMode
    }
}

extension Color {
    
    static var goseiRed: Color  {
        return Color(red: 255/255.0, green: 39/255.0, blue: 42/255.0)
    }
    
    static var goseiWhite: Color {
        return Color(red: 1.0, green: 1.0, blue: 1.0)
    }
    
    static var lightGray: Color {
        return Color(uiColor: UIColor.lightGray)
    }
    
    static var goseiDark: Color {
        return Color(red: 31/255.0, green: 29/255.0, blue: 43/255.0)
    }
    
    static var darkGray: Color {
        return Color(white: 113 / 255.0)
    }
    
    static var gray241: Color {
        return Color(white: 241 / 255.0)
    }
    
    static var gray21: Color {
        return Color(white: 21 / 255.0)
    }
    
    static var background: Color {
        lightMode ? .white : .black
    }
    
    static var backgroundAccent: Color {
        lightMode ? gray241 : gray21
    }
    
    static var text: Color {
        lightMode ? .black : .white
    }
    
    static let facebookBlue = Color(red: 66 / 255.0, green: 103 / 255.0, blue: 178 / 255.0)
}
