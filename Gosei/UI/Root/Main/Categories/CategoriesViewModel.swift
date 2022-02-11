//
//  CategoriesViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.01.2022..
//

import Foundation

final class CategoriesViewModel: ObservableObject {
    
    var onDismissed: EmptyCallback?
    var goToCategory: ((ProductCategory) -> Void)?
    
    init() {
        
    }
    
}

// MARK: Interaction
extension CategoriesViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
    
    func categoryTapped(_ category: ProductCategory) {
        goToCategory?(category)
    }
}
