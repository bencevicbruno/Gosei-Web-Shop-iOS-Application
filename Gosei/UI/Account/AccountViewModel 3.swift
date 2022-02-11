//
//  AccountViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import Foundation

final class AccountViewModel: ObservableObject {
    
    var user: PersistenceData.User
    
    var onDismissed: EmptyCallback?
    var goToAccountInfo: ((PersistenceData.User) -> Void)?
    var goToMyOrders: EmptyCallback?
    var goToLanguages: EmptyCallback?
    var goToHelp: EmptyCallback?
    
    init(user: PersistenceData.User) {
        self.user = user
    }
    
    
    
    
    
    var firstName: String {
        user.name.components(separatedBy: " ").first ?? "MissingNo"
    }
    
    func toggleDarkMode(darkMode: Bool? = nil) {
//        if let darkMode = darkMode {
//            // switchAcordingly
//        } else {
//            // just toggle
//        }
    }
}

// MARK: - Navigation
extension AccountViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
    
    func accountInfoTapped() {
        self.goToAccountInfo?(user)
    }
    
    func helpTapped() {
        self.goToHelp?()
    }
}
