//
//  Font+.swift
//  Gosei
//
//  Created by Bruno Benčević on 10.01.2022..
//

import Foundation
import SwiftUI

extension Font {
    
    static func playfair(_ size: CGFloat = 16, _ style: Font.Style = .regular) -> Font {
        let file = style == .regular ? "PlayfairDisplay-Regular" : "PlayfairDisplayRoman-\(style.rawValue)"
        return Font.custom(file, size: size)
    }
    
    static func workSans(_ size: CGFloat = 16, _ style: Font.Style = .regular) -> Font {
        let file = style == .regular ? "WorkSans-Regular" : "WorkSansRoman-\(style.rawValue)"
        return Font.custom(file, size: size)
    }
}

extension Font {
    enum Style: String {
        case regular = "Regular"
        case thin = "Thin"
        case extraLight = "ExtraLight"
        case light = "Light"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
        case extraBold = "ExtraBold"
        case black = "Black"
    }
}

extension Font {
    
    // MARK: - Utility
    static func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}

