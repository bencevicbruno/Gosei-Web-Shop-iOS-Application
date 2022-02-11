//
//  HomeViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var currentSliderCategory: ProductCategory = .kitchenAppliances
    
    var onScroll: ((ScrollDirection) -> Void)?
    var onGoToProduct: ((Product) -> Void)?
    var onGoToCategory: ((ProductCategory) -> Void)?
    var onGoToCategories: EmptyCallback?
    
    var promotionalProducts: [Product]
    var promotionalCategories: [ProductCategory]
    
    init() {
        promotionalProducts = [.test, .testFavorite, .testFavorite, .test]
        promotionalCategories = ProductCategory.allCases.shuffled().dropLast(2)
    }
}

// MARK: - Interaction
extension HomeViewModel {
    
    func onDragged(_ value: DragGesture.Value) {
        guard abs(value.translation.width) < 100 else { return }
        
        withAnimation {
            onScroll?(value.translation.height < 0 ? .down : .up)
        }
    }
    
    func productTapped(_ product: Product) {
        self.onGoToProduct?(product)
    }
    
    func categoryTapped(_ category: ProductCategory) {
        self.onGoToCategory?(category)
    }
    
    func browseAllCategoriesTapped() {
        self.onGoToCategories?()
    }
}
