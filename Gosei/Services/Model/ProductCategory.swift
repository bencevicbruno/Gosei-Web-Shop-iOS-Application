//
//  ProductCategory.swift
//  Gosei
//
//  Created by Bruno Benčević on 22.01.2022..
//

import Foundation

enum ProductCategory: CaseIterable, Identifiable {
    case kitchenAppliances
    case homeSecurity
    case appleDevices
    case vacuumCleaners
    case smartLighting
    case temperatureControl
    
    var id: Self {
        self
    }
    
    var name: String {
        switch(self) {
        case .kitchenAppliances: return Localizable.kitchen_appliances.localized
        case .homeSecurity: return Localizable.home_security.localized
        case .appleDevices: return Localizable.apple_devices.localized
        case .vacuumCleaners: return Localizable.vacuum_cleaners.localized
        case .smartLighting: return Localizable.smart_lighting.localized
        case .temperatureControl: return Localizable.temperature_control.localized
        }
    }
    
    var imageName: String {
        "\(self)"
    }
    
    var previous: ProductCategory {
        let allCases = Self.allCases
        let lastIndex = (allCases.firstIndex(of: self) ?? 0) - 1
        
        return allCases[lastIndex < 0 ? allCases.count - 1 : lastIndex]
    }
    
    var next: ProductCategory {
        let allCases = Self.allCases
        let nextIndex = (allCases.firstIndex(of: self) ?? 0) + 1
        
        return allCases[nextIndex % allCases.count]
    }
}

private extension ProductCategory {
    
    static func getTitle(_ category: Self) -> String {
        switch category {
        case .kitchenAppliances: return "Kitchen Appliances"
        case .homeSecurity: return "Home Security"
        case .appleDevices: return "Apple Devices"
        case .vacuumCleaners: return "Vacuum Cleaners"
        case .smartLighting: return "Smart Lighting"
        case .temperatureControl: return "Temperature Control"
        }
    }
}
