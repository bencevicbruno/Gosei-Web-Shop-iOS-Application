//
//  SwipeGestures.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import SwiftUI

extension View {
    
    func onSwipe(_ swipe: SwipeDirection, distance: CGFloat = 0, action: EmptyCallback? = nil) -> some View {
        self.simultaneousGesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded { value in
            if swipe == .left && value.translation.width < 0 {
                action?()
            } else if swipe == .right && value.translation.width > 0 {
                action?()
            } else if swipe == .up && value.translation.height < 0 {
                action?()
            } else if swipe == .down && value.translation.height > 0 {
                action?()
            }
        })
    }
    
    func onSwipe(_ swipe: SwipeDirection, distance: CGFloat = 0) -> some View {
        return self.onSwipe(swipe, distance: distance, action: nil)
    }
}

enum SwipeDirection {
    case left, right, up, down
}
