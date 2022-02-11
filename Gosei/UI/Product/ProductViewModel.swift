//
//  ProductViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.01.2022..
//

import Foundation
import SwiftUI

final class ProductViewModel: ObservableObject {
    
    @Published var currentTab: Tab = .description
    
    var product: Product
    
    var onDismissed: EmptyCallback?
    var onBuyNowTapped: EmptyCallback?
    
    init(product: Product) {
        self.product = product
    }
    
    func switchToTab(_ tab: Tab) {
        withAnimation {
            currentTab = tab
        }
    }
}

// MARK: - Interaction
extension ProductViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
    
    func buyNowTapped() {
        self.onBuyNowTapped?()
    }
    
    func addToCardTapped() {
        
    }
}

extension ProductViewModel {
    
    enum Tab: Hashable {
        case description
        case shippingInfo
        case paymentOptions
    }
}
