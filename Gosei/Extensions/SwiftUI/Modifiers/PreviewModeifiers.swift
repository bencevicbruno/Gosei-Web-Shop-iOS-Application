//
//  PreviewModeifiers.swift
//  Gosei
//
//  Created by Bruno Benčević on 01.02.2022..
//

import SwiftUI

extension View {
    
    func previewDevices(_ device: ViewPreviewDevice, _ devices: ViewPreviewDevice...) -> some View {
        Group {
            self
                .previewDevice(.init(rawValue: device.rawValue))
                .previewDisplayName(device.rawValue)
            
            ForEach(devices) { device in
                self
                    .previewDevice(.init(rawValue: device.rawValue))
                    .previewDisplayName(device.rawValue)
            }
        }
    }
}

enum ViewPreviewDevice: String, Identifiable {
    case iPhoneSE = "iPhone SE (1st generation)"
    case iPhone8 = "iphone 8"
    case iphoneSE2 = "iPhone (2nd generation)"
    case iPhone13 = "iPhone 13"
    
    var id: Self {
        self
    }
}
