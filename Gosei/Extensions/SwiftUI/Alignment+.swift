//
//  Alignment+.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import SwiftUI

extension VerticalAlignment {
    
    private struct HamburgerMenuAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let hamburgerMenuAlignmentGuide = VerticalAlignment(HamburgerMenuAlignment.self)
}
