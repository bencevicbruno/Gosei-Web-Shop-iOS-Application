//
//  CartViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import Foundation
import SwiftUI

final class CartViewModel: ObservableObject {
    
    var onScroll: ((ScrollDirection) -> Void)?
    
    var products: [Product]
    
    init() {
        products = (1...(Int.random(in: 1...5))).reduce(into: []) { result, _ in
            result.append(.random())
        }

    }
    
    func onDragged(_ value: DragGesture.Value) {
        withAnimation {
            onScroll?(value.translation.height < 0 ? .down : .up)
        }
    }
}

// MARK: - Interaction
extension CartViewModel {
    
    func minusTapped() {
        
    }
    
    func plusTapped() {
        
    }
    
}
