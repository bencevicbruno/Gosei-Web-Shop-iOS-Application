//
//  LineGraphShape.swift
//  Gosei
//
//  Created by Bruno Benčević on 10.03.2022..
//

import SwiftUI


struct LineGraphShape: Shape {
    let dataset: Dataset
    let isMask: Bool
    
    func path(in rect: CGRect) -> Path {
        
        return Path { p in
            p.move(to: dataset.getPoint(at: 0, in: rect))
            
            for index in dataset.values.indices {
                p.addLine(to: dataset.getPoint(at: index, in: rect))
            }
            
            if isMask {
                p.addLine(to: CGPoint(x: rect.width, y: rect.height))
                p.addLine(to: CGPoint(x: 0, y: rect.height))
            }
        }
    }
    
    init(dataset: Dataset, isMask: Bool = false) {
        self.dataset = dataset
        self.isMask = isMask
    }
}

struct LineGraphShape_Previews: PreviewProvider {
    static var previews: some View {
        LineGraphShape(dataset: Dataset([10, 90, 20, 40, 50, 100, 12]), isMask: true)
    }
}
