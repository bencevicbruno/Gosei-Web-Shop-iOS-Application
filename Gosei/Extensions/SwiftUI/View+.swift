//
//  View+.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.11.2021..
//

import SwiftUI

extension View {
    func frame(size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
    
    func isHidden(_ isHidden: Bool) -> some View {
        self.opacity(isHidden ? 0 : 1)
    }
}
