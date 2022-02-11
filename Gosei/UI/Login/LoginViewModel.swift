//
//  LoginViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.01.2022..
//

import Foundation
import Combine
import GoogleSignIn

final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var areCredidentialsInvalid = false
    @Published var externalLoginSheet: ExternalLoginType? = nil
    
    var navigationController: UINavigationController
    var persistenceService: PersistenceServiceProtocol
    
    var onGoToSignUp: EmptyCallback?
    var onGoToMain: ((PersistenceData.User) -> Void)?
    
    init(navigationController: UINavigationController, persistenceService: PersistenceServiceProtocol) {
        self.navigationController = navigationController
        self.persistenceService = persistenceService
    }
}

// MARK: - Interaction
extension LoginViewModel {
    
    func googleSignInTapped() {
        GIDSignIn.sharedInstance.signIn(with: GIDConfiguration(clientID: "1074481682711-1rj2m9gt6htoo8m932rgtrc6gq7ugelp.apps.googleusercontent.com"), presenting: navigationController) { [weak self] user, error in
            guard let self = self else { return }
            guard error == nil, let profile = user?.profile else { return }
            
            let name = profile.name
            let email = profile.email
            let imageURL = profile.imageURL(withDimension: 200)
            
            let user = PersistenceData.User(name: name, email: email, address: "Negde u Oseku", phoneNumber: "095 581 7660", birthday: nil, avatarURL: imageURL)
            self.persistenceService.user = user
            
            self.onGoToMain?(user)
          }
    }
    
    func facebookSignInTapped() {
        externalLoginSheet = .facebook
    }
    
    func appleSignInTapped() {
        externalLoginSheet = .apple
    }
    
    func closeExternalLoginSheet() {
        externalLoginSheet = nil
    }
    
    func loginTapped() {
        let user = PersistenceData.User(name: "Karlo Vuletic", email: "vuletic.karlo@gmail.com", address: "dunno where", phoneNumber: "+385 95 581 7660", birthday: Date(day: 26, month: 6, year: 1999), avatarURL: nil)
        self.onGoToMain?(user)
    }
}
