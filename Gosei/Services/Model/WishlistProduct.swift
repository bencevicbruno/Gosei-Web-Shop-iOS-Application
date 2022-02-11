//
//  WishlistProduct.swift
//  Gosei
//
//  Created by Bruno Benčević on 23.01.2022..
//

import Foundation

struct WishlistProduct: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let isFavorite: Bool
    
    static var test: WishlistProduct {
        WishlistProduct(name: "test", imageName: "test_iPhone", isFavorite: true)
    }
    
    static func random() -> Self {
        return .init(name: .random(), imageName: "test_iPhone", isFavorite: Bool.random())
    }
}
