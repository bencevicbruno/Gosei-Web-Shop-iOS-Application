//
//  ChangePasswordViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import Foundation
import Combine

final class ChangePasswordViewModel: ObservableObject {
    
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var repeatedNewPassword = ""
    @Published var oldPasswordValid = true
    @Published var newPaswordMatching = true
    
    var user: PersistenceData.User
    
    var onDismissed: EmptyCallback?
    
    private var subscribers = Set<AnyCancellable>()
    
    init(user: PersistenceData.User) {
        self.user = user
        setupSubscribers()
    }
}

// MARK: - Interaction
extension ChangePasswordViewModel {
    
    func saveTapped() {
        self.onDismissed?()
    }
}

// MARK: - Navigation
extension ChangePasswordViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
}

private extension ChangePasswordViewModel {
    
    func setupSubscribers() {
        $newPassword
            .combineLatest($repeatedNewPassword)
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] password, repeatedPassword in
                self?.newPaswordMatching = password == repeatedPassword
            }
            .store(in: &subscribers)
    }
}
