//
//  WishlistViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import Foundation
import SwiftUI

final class WishlistViewModel: ObservableObject {
    
    var onScroll: ((ScrollDirection) -> Void)?
    
    var products: [WishlistProduct]
    
    init() {
        products = (1...10).reduce(into: []) { result, _ in
            result.append(.random())
        }
    }
    
    func onDragged(_ value: DragGesture.Value) {
        withAnimation {
            onScroll?(value.translation.height < 0 ? .down : .up)
        }
    }
}
