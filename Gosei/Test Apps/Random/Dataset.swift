//
//  Dataset.swift
//  Gosei
//
//  Created by Bruno Benčević on 10.03.2022..
//

import Foundation
import CoreGraphics
import UIKit

struct Dataset {
    var values: [Double]!
    let min: Double
    let max: Double
    
    init(_ values: [Double], normalize: Bool = true) {
        self.min = values.min()!
        self.max = values.max()!
        
        if normalize {
            self.values = values.map { value in
                return (value - min) / range
            }
        } else {
            self.values = values
        }
    }
    
    var range: Double {
        max - min
    }
    
    func getPoint(at index: Int, in rect: CGRect) -> CGPoint {
        let point = values[index]
        
        let x = rect.width * CGFloat(index) / CGFloat(values.count - 1)
        let y = (1 - point) * rect.height
        
        return CGPoint(x: x, y: y)
    }
    
    subscript(index: Int) -> Double {
        get {
            values[index]
        }
    }
    
    func drawGraph(in rect: CGRect, asMask: Bool = false) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        
        return renderer.image { context in
            
            context.cgContext.move(to: getPoint(at: 0, in: rect))
            
            for index in values.indices {
                context.cgContext.addLine(to: getPoint(at: index, in: rect))
            }
            
            if asMask {
                context.cgContext.addLine(to: CGPoint(x: rect.width, y: rect.height))
                context.cgContext.addLine(to: CGPoint(x: 0, y: rect.height))
            }
//            context.cgContext.closePath()
            
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(2)
            context.cgContext.drawPath(using: .stroke)
        }
    }
}
