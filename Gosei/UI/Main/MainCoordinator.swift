//
//  MainCoordinator.swift
//  Gosei
//
//  Created by Bruno Benčević on 26.01.2022..
//

import Foundation
import UIKit
import SwiftUI

final class MainCoordinator: Coordinator, ObservableObject {
    
    var childCoordinator: Coordinator?
    let navigationController: UINavigationController
    let childNavigationController = UINavigationController()
    var refresh: Bool = false
    var refreshToken: Binding<Bool>!
    
    var onDismissed: EmptyCallback?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        refreshToken = Binding<Bool>(get: { self.refresh }, set: { self.refresh = $0 })
    }
    
    func start(user: PersistenceData.User) {
        let vm = MainViewModel(user: user)
        let vc = UIHostingController(rootView: MainView(viewModel: vm))
        
        vm.goToAccount = { [weak self, weak vm] user in
            self?.showAccount(user: user) { [weak vm] in
                vm?.refresh()
            }
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
        
        childNavigationController.viewControllers = []
        navigationController.viewControllers = [vc]
    }
}

private extension MainCoordinator {
    
    func goToLogin() {
        self.onDismissed?()
    }
    
    func showAccount(user: PersistenceData.User, onDismissed: EmptyCallback? = nil) {
        let accountCoordinator = AccountCoordinator(navigationController: navigationController)
        self.childCoordinator = accountCoordinator
        
        accountCoordinator.onDismissed = { [weak self] shouldRedraw in
            self?.childCoordinator = nil
            onDismissed?()
        }
        
        accountCoordinator.start(user: user)
    }
    
    func showProduct(_ product: Product) {
        let vm = ProductViewModel(product: product)
        let vc = UIHostingController(rootView: ProductView(viewModel: vm))
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        vm.onBuyNowTapped = { [weak self] in
            self?.showCheckout()
        }
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showCheckout() {
        let vm = CheckoutViewModel()
        let vc = UIHostingController(rootView: CheckoutView(viewModel: vm))
        
        vm.onXTapped = { [weak self] in
            self?.navigationController.dismiss(animated: true)
        }
        
        vm.onReturnToHomePageTapped = { [weak self] in
            self?.navigationController.dismiss(animated: true)
            self?.navigationController.popToRootViewController(animated: true)
        }
        
        childNavigationController.pushViewController(vc, animated: true)
        childNavigationController.modalPresentationStyle = .fullScreen
        navigationController.present(childNavigationController, animated: true)
    }
    
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
