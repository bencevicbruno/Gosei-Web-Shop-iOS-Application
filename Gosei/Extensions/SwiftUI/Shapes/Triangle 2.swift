//
//  Triangle.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import SwiftUI

struct Triangle: Shape {
    
    let points: [CGPoint]
    
    init(points: [CGPoint]) {
        self.points = points
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var realPoints = [CGPoint]()
        points.forEach { point in
            realPoints.append(CGPoint(x: rect.minX + rect.width * point.x, y: rect.minY + rect.height * point.y))
        }
        
        path.move(to: realPoints[0])
        path.addLines([
            realPoints[1],
            realPoints[2],
            realPoints[0]
        ])
        
        return path
    }
}
