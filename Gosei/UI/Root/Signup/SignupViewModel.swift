//
//  SignupViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.01.2022..
//

import Foundation
import Combine

final class SignupViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var repeatedPassword = ""
    @Published var arePasswordsMathing = true
    @Published var externalSignupSheet: ExternalLoginType? = nil
    
    var onDismiss: EmptyCallback?
    var onSignUpTapped: EmptyCallback?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
}

// MARK: - Interaction
extension SignupViewModel {
    
    func dismiss() {
        self.onDismiss?()
    }
    
    func signUpTapped() {
        self.onSignUpTapped?()
    }
    
    func closeExternalSignupSheet() {
        externalSignupSheet = nil
    }
    
    func googleSingupTapped() {
        externalSignupSheet = .google
    }
    
    func facebookSignupTapped() {
        externalSignupSheet = .facebook
    }
    
    func appleSignupTapped() {
        externalSignupSheet = .apple
    }
}

private extension SignupViewModel {
    
    func setupSubscribers() {
        $password
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] newPassword in
                guard let self = self else { return }
                
                self.arePasswordsMathing = newPassword == self.repeatedPassword
            }
            .store(in: &cancellables)
        
        $repeatedPassword
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] newRepeatedPassword in
                guard let self = self else { return }
                
                self.arePasswordsMathing = newRepeatedPassword == self.password
            }
            .store(in: &cancellables)
    }
}
