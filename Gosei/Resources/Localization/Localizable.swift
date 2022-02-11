//
//  Localizable.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.11.2021..
//

import Foundation
import Fusion

enum Localizable {
    /// cancel
    case cancel
    /// close
    case close
    /// confirm
    case confirm
    /// email
    case email
    /// log in
    case log_in
    case login_is_not_implemented
    case new_to_gosei
    case or
    case password
    case passwords_not_matching
    case payment_details
    case payment_successful
    case repeat_password
    case shipping_details
    // sign out
    case sign_out
    // Are you sure you want to sign out? You can sign in again later.
    case sign_out_message
    case sign_up
    case wrong_credidentials
    
    case account_info
    case my_orders
    case language
    case help
    case light
    case dark
    
    case kitchen_appliances
    case home_security
    case apple_devices
    case vacuum_cleaners
    case smart_lighting
    case temperature_control
    
    case promotional_products

    
    var localized: String {
        if let lang = Self.persistenceService.langauge {
            let path = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj")!
            let bundle = Bundle(path: path)!
            return NSLocalizedString("\(self)", bundle: bundle, comment: "")
        } else {
            return NSLocalizedString("\(self)", comment: "")
        }
    }
}

extension Localizable {
    @Inject fileprivate static var persistenceService: PersistenceServiceProtocol
}
