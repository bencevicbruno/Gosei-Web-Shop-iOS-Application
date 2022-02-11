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
    
    private var user: PersistenceData.User
    
    init(user: PersistenceData.User) {
        self.user = user
    }
    
    var name: String {
        user.name
    }
    
    var email: String {
        user.email
    }
    
    var address: String {
        user.address ?? "Unknown"
    }
    
    var phoneNumber: String {
        user.phoneNumber ?? "Unknown"
    }
    
    var dateOfBirth: String {
        user.birthday?.asString ?? "Unknown"
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
