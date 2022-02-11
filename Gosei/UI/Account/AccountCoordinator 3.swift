//
//  AccountCoordinator.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.02.2022..
//

import Foundation
import UIKit
import SwiftUI

final class AccountCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var shouldRedrawWhenDismissed = false
    
    var onDismissed: ((_ shouldRedraw: Bool) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(user: PersistenceData.User) {
        let vm = AccountViewModel(user: user)
        let vc = UIHostingController(rootView: AccountView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            guard let self = self else { return }
            self.navigationController.popViewController(animated: !self.shouldRedrawWhenDismissed)
            self.onDismissed?(self.shouldRedrawWhenDismissed)
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
        
        vm.onRedraw = { [weak self, weak vm] in
            guard let vm = vm else { return }
            self?.navigationController.popViewController(animated: false)
            self?.navigationController.pushViewController(UIHostingController(rootView: AccountView(viewModel: vm)), animated: false)
            self?.shouldRedrawWhenDismissed = true
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
}

private extension AccountCoordinator {
    
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
