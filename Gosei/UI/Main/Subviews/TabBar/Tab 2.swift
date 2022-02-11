//
//  Tab.swift
//  Gosei
//
//  Created by Bruno Benčević on 30.11.2021..
//

import SwiftUI

enum Tab: Identifiable, CaseIterable {
    case home
    case search
    case wishlist
    case cart
    
    var id: Self {
        self
    }
    
    var title: String {
        "\(self)".capitalized
    }
    
    var image: Image {
        Image("tab_\(self)")
    }
}
