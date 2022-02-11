//
//  AccountViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import Foundation
import SwiftUI
import Fusion

final class AccountViewModel: ObservableObject {
    
    @Inject var persistenceService: PersistenceServiceProtocol
    
    @Published var refreshToken = true
    
    var user: PersistenceData.User!
    var interactionEnabled = true
    
    var onDismissed: EmptyCallback?
    var goToAccountInfo: ((PersistenceData.User) -> Void)?
    var goToMyOrders: EmptyCallback?
    var goToLanguages: EmptyCallback?
    var goToHelp: EmptyCallback?
    
    var onRefreshed: EmptyCallback?
    
    init() {
        self.user = persistenceService.user!
    }
    
    var firstName: String {
        user.name.components(separatedBy: " ").first ?? "MissingNo"
    }
    
    func toggleColorScheme() {
        persistenceService.colorScheme = persistenceService.useLightMode ? .dark : .light
        refresh()
    }
    
    func setColorScheme(_ newScheme: PersistenceData.ColorScheme) {
        persistenceService.colorScheme = newScheme
        refresh()
    }
    
    func refresh(animated: Bool = true) {
        let duration = animated ? 1.0 : 0.0
        interactionEnabled = false
        
        withAnimation(.linear(duration: duration)) {
            refreshToken.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.interactionEnabled = true
            self.objectWillChange.send()
        }
        
        self.onRefreshed?()
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
