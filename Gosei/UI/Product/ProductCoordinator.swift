//
//  ProductCoordinator.swift
//  Gosei
//
//  Created by Bruno Benčević on 11.02.2022..
//

import Foundation
import UIKit
import SwiftUI

final class ProductCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let childNavigationController = UINavigationController()
    
    var onDismissed: EmptyCallback?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(product: Product) {
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
}
