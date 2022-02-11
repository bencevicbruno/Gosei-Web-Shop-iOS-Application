//
//  CategoryViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.01.2022..
//

import Foundation

final class CategoryViewModel: ObservableObject {
    
    var category: ProductCategory
    
    var onDismissed: EmptyCallback?
    var goToProduct: ((Product) -> Void)?
    
    init(category: ProductCategory) {
        self.category = category
    }
}

// MARK: Interaction
extension CategoryViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
    
    func productTapped(_ product: Product) {
        goToProduct?(product)
    }
}
