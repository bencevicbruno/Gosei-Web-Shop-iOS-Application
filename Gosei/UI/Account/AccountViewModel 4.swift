//
//  AccountViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import Foundation
import Fusion

final class AccountViewModel: ObservableObject {
    
    @Inject var persistenceService: PersistenceServiceProtocol
    
    var user: PersistenceData.User
    
    var onDismissed: EmptyCallback?
    var goToAccountInfo: ((PersistenceData.User) -> Void)?
    var goToMyOrders: EmptyCallback?
    var goToLanguages: EmptyCallback?
    var goToHelp: EmptyCallback?
    
    var onRedraw: EmptyCallback?
    
    init(user: PersistenceData.User) {
        self.user = user
    }
    
    var firstName: String {
        user.name.components(separatedBy: " ").first ?? "MissingNo"
    }
    
    func toggleColorScheme() {
        persistenceService.colorScheme = persistenceService.useLightMode ? .dark : .light
        self.onRedraw?()
    }
    
    func setColorScheme(_ newScheme: PersistenceData.ColorScheme) {
        persistenceService.colorScheme = newScheme
        self.onRedraw?()
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
