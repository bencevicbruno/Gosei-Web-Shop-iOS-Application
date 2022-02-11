//
//  RightTriangle.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.11.2021..
//

import SwiftUI

struct RightTriangle: Shape {
    
    private var rightAngleLocation: RightAngleLocation
    
    init(_ rightAngleLocation: RightAngleLocation) {
        self.rightAngleLocation = rightAngleLocation
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        switch rightAngleLocation {
        case .topLeft:
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLines([
                CGPoint(x: rect.maxX, y: rect.minY),
                CGPoint(x: rect.minX, y: rect.maxY),
                CGPoint(x: rect.minX, y: rect.minY)
            ])
        case .topRight:
            fatalError("RightTriangle#topRight not implemented")
        case .bottomLeft:
            fatalError("RightTriangle#bottomLeft not implemented")
        case .bottomRight:
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLines([
                CGPoint(x: rect.maxX, y: rect.maxY),
                CGPoint(x: rect.minX, y: rect.maxY),
                CGPoint(x: rect.maxX, y: rect.minY)
            ])
        }
        
        return path
    }
}

extension RightTriangle {
    enum RightAngleLocation {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
}
