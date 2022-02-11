//
//  RootCoordinator.swift
//  Gosei
//
//  Created by Bruno Benčević on 16.01.2022..
//

import Foundation
import UIKit
import SwiftUI

final class RootCoordinator: Coordinator {
    
    let navigationController = UINavigationController()
    let childNavigationController = UINavigationController()
    
    func start() -> UIViewController {
        let persistenceService = PersistenceService()
        
        let vc = UIHostingController(rootView: LaunchScreen())
        navigationController.viewControllers = [vc]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            if let user = persistenceService.user {
                self?.goToMain(user: user)
            } else {
                self?.goToLogin()
            }
        }
        
        return navigationController
    }
    
    func goToLogin() {
        let vm = LoginViewModel()
        let vc = UIHostingController(rootView: LoginView(viewModel: vm))
        
        vm.goToSignUp = { [weak self] in
            self?.goToSignUp()
        }
        
        vm.goToMain = { [weak self] user in
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
        let vm = MainViewModel(user: user)
        let vc = UIHostingController(rootView: MainView(viewModel: vm))
        
        vm.goToAccount = { [weak self] user in
            self?.showAccount(user: user)
        }
        
        vm.goToCategories = { [weak self] in
            self?.showCategories()
        }
        
        vm.goToSignOut = { [weak self] in
            self?.goToLogin()
        }
        
        vm.goToProduct = { [weak self] product in
            self?.showProduct(product)
        }
        
        vm.goToCategory = { [weak self] category in
            self?.showCategory(category)
        }
        
        navigationController.viewControllers = [vc]
    }
    
    func showProduct(_ product: Product) {
        let vm = ProductViewModel(product: product)
        let vc = UIHostingController(rootView: ProductView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        self.navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - Categories Navigation (move to separate coordinator?)
extension RootCoordinator {
    
    func showCategories() {
        let vm = CategoriesViewModel()
        let vc = UIHostingController(rootView: CategoriesView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        vm.goToCategory = { [weak self] category in
            self?.showCategory(category)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCategory(_ category: ProductCategory) {
        let vm = CategoryViewModel(category: category)
        let vc = UIHostingController(rootView: CategoryView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        vm.goToProduct = { [weak self] product in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
}


// MARK: - Account Navigation (move to separate coordinator?)
extension RootCoordinator {
    
    func showAccount(user: PersistenceData.User) {
        let vm = AccountViewModel(user: user)
        let vc = UIHostingController(rootView: AccountView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        vm.goToAccountInfo = { [weak self] user in
            self?.showAccountInfo(user: user)
        }
        
        vm.goToMyOrders = { [weak self] in
            self?.showMyOrders()
        }
        
        vm.goToLanguages = { [weak self] in
            self?.showLanguages()
        }
        
        vm.goToHelp = { [weak self] in
            self?.showHelp()
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAccountInfo(user: PersistenceData.User) {
        let vm = AccountInfoViewModel(user: user)
        let vc = UIHostingController(rootView: AccountInfoView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        vm.goToChangeInfo = { [weak self] in
            self?.showChangeInfo(user: user)
        }
        
        vm.goToChangePassword = { [weak self] user in
            self?.showChangePassword(user: user)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showChangeInfo(user: PersistenceData.User) {
        let vm = ChangeInfoViewModel(user: user)
        let vc = UIHostingController(rootView: ChangeInfoView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showChangePassword(user: PersistenceData.User) {
        let vm = ChangePasswordViewModel(user: user)
        let vc = UIHostingController(rootView: ChangePasswordView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMyOrders() {
        let vm = MyOrdersViewModel()
        let vc = UIHostingController(rootView: MyOrdersView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showLanguages() {
        let vm = LanguageViewModel(persistenceService: PersistenceService())
        let vc = UIHostingController(rootView: LanguageView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showHelp() {
        let vm = HelpViewModel()
        let vc = UIHostingController(rootView: HelpView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
}
