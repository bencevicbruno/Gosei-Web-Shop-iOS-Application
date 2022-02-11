//
//  ItemCategory.swift
//  Gosei
//
//  Created by Bruno Benčević on 10.01.2022..
//

import Foundation

enum ItemCategory: String, CaseIterable {
    case kitchenAppliances = "Kitchen Appliances"
    case homeSecurity = "Home Security"
    case appleDevices = "Apple Devices"
    case vacuumCleaners = "Vaccum Cleaners"
    case smartLighting = "Smart Lighting"
    case roomTemperature = "Room Temperature"
    
    var name: String {
        "\(self.rawValue)"
    }
    
    var imageName: String {
        "category_\(self)"
    }
    
    var sliderImageName: String {
        "category_slider_\(self)"
    }
}
