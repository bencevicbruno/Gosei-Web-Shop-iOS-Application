//
//  Image+.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.02.2022..
//

import Foundation
import SwiftUI
import Fusion

extension Image {
    @Inject fileprivate static var persistenceService: PersistenceServiceProtocol
    
    fileprivate static var darkMode: Bool {
        persistenceService.useDarkMode
    }
}

extension Image {
    
    init(_ asset: Image.Asset) {
        self.init("\(asset)")
    }
    
    init(_ schemedAsset: Image.SchemedAsset) {
        if Self.darkMode {
            self.init("\(schemedAsset)_dark")
        } else {
            self.init("\(schemedAsset)")
        }
    }
}

extension Image {
    
    static var gosei_logo: Image {
        darkMode ? Image("gosei_logo_dark") : Image("gosei_logo")
    }
    
    static var icon_arrowLeft: Image {
        darkMode ? Image("icon_arrowLeft_dark") : Image("icon_arrowLeft")
    }
    
    enum Asset {
        case logo_facebook
        case logo_google
    }
    
    enum SchemedAsset {
        
        case gosei_logo
        case icon_arrowLeft
        case icon_avatar
        case icon_lightMode
        case logo_apple
        case icon_heart
        case icon_slash
        case icon_heart_filled
        case icon_triangleRight_filled
        case icon_creditCard
        case icon_x
        case icon_truck
        case icon_checkMark
        case tab_home
        case tab_search
        case tab_wishlist
        case tab_cart
        case ilustration_checkoutSucessful
        case icon_edit
        case icon_camera
        
    }
}
