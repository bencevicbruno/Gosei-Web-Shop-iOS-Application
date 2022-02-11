//
//  Product.swift
//  Gosei
//
//  Created by Bruno Benčević on 22.01.2022..
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let isFavorite: Bool
    
    static var test: Product {
        Product(name: "iPhone", imageName: "test_iPhone", isFavorite: false)
    }
    
    static var testFavorite: Product {
        Product(name: "iPhone", imageName: "test_iPhone", isFavorite: true)
    }
    
    static func random() -> Self {
        return Product(name: .random(), imageName: "test_iPhone", isFavorite: Bool.random())
    }
    
    var price: Int {
        Int.random(in: 100...3000)
    }
    
    var tinyInfo: String {
        "256 GB, silver"
    }
    
    var description: String {
        "The iPhone 13 Pro is Apple's smaller premium iPhone with a 6.1\" screen size and for the first time in an iPhone, it comes with a 120Hz ProMotion display for super smooth scrolling. The list of innovations includes a more capable triple camera setup, with a wide, ultra-wide and zoom cameras, as well as a LiDAR scanner."
    }
    
    var info: [TableInfo] {
        [
            TableInfo(title: "Screen", info: [
                ["Product Type", "Smart phone"],
                ["Brand", "Apple"],
                ["Color", "Silver"]]),
            TableInfo(title: "battery", info: [
                ["Capacity", "4500 mAh"],
                ["Type", "lithium-ion"]
            ])
        ]
    }
    
    struct TableInfo: Codable {
        let title: String
        let info: [[String]]
    }
}
