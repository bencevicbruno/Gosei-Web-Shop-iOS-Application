//
//  AccountInfoViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import Foundation

final class AccountInfoViewModel: ObservableObject {
    
    var onDismissed: EmptyCallback?
    var goToChangePicture: EmptyCallback?
    var goToChangeInfo: EmptyCallback?
    var goToChangePassword: ((PersistenceData.User) -> Void)?
    
    var user: PersistenceData.User
    
    init(user: PersistenceData.User) {
        self.user = user
    }
}

// MARK: - Interaction
extension AccountInfoViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
    
    func changePictureTapped() {
        self.goToChangePicture?()
    }
    
    func changeInfoTapped() {
        self.goToChangeInfo?()
    }
    
    func changePasswordTapped() {
        self.goToChangePassword?(user)
    }
}
