//
//  RootCoordinator.swift
//  Gosei
//
//  Created by Bruno Benčević on 16.01.2022..
//

import Foundation
import UIKit
import SwiftUI
import GoogleSignIn

final class RootCoordinator: Coordinator {
    
    var childCoordinator: Coordinator?
    let navigationController: UINavigationController
    let services: ServicesProtocol
    
    init(navigationController: UINavigationController, services: ServicesProtocol) {
        self.navigationController = navigationController
        self.services = services
    }
    
    func start() {
        let persistenceService = services.persistenceService
        
        let vc = UIHostingController(rootView: LaunchScreen())
        navigationController.viewControllers = [vc]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if error != nil || user == nil {
                    self.goToLogin()
                } else {
                    if let user = persistenceService.user {
                        self.goToMain(user: user)
                    } else {
                        self.goToLogin()
                    }
                }
            }
        }
    }
}

private extension RootCoordinator {
    
    func goToLogin() {
        let vm = LoginViewModel(navigationController: self.navigationController, persistenceService: self.services.persistenceService)
        let vc = UIHostingController(rootView: LoginView(viewModel: vm))
        
        vm.onGoToSignUp = { [weak self] in
            self?.goToSignUp()
        }
        
        vm.onGoToMain = { [weak self] user in
            self?.goToMain(user: user)
        }
        
        navigationController.viewControllers = [vc]
    }
    
    func goToSignUp() {
        let vm = SignupViewModel()
        let vc = UIHostingController(rootView: SignupView(viewModel: vm))
        
        vm.onDismiss = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToMain(user: PersistenceData.User) {
        let mainCoordinator = MainCoordinator(navigationController: self.navigationController)
        self.childCoordinator = mainCoordinator
        
        mainCoordinator.onDismissed = { [weak self] in
            self?.childCoordinator = nil
            self?.goToLogin()
        }
        
        mainCoordinator.start(user: user)
    }
}
