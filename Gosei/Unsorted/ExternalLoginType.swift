//
//  ExternalLoginType.swift
//  Gosei
//
//  Created by Bruno Benčević on 02.02.2022..
//

import Foundation
import SwiftUI

enum ExternalLoginType: String, Identifiable {
    case google = "Google"
    case facebook = "Facebook"
    case apple = "Apple"
    
    var logoImage: Image {
        switch(self) {
        case .google: return Image(.logo_google)
        case .facebook: return Image(.logo_facebook)
        case .apple: return Image(.logo_apple)
        }
    }
    
    var id: Self {
        self
    }
}
