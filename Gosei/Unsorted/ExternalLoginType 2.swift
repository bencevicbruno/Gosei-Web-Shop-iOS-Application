//
//  ExternalLoginType.swift
//  Gosei
//
//  Created by Bruno Benčević on 02.02.2022..
//

import Foundation

enum ExternalLoginType: String, Identifiable {
    case google = "Google"
    case facebook = "Facebook"
    case apple = "Apple"
    
    var imageName: String {
        "\(self)_logo"
    }
    
    var id: Self {
        self
    }
}
