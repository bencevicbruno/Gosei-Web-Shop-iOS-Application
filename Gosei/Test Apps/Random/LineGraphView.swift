//
//  LineGraphView.swift
//  Gosei
//
//  Created by Bruno Benčević on 11.02.2022..
//

import SwiftUI

struct LineGraphView: View {
    
    private var data: [Double]
    
    @State private var didAnimate = false
    
    var body: some View {
        LineGraph(data: data)
            .trim(to: didAnimate ? 1 : 0)
            .stroke(Color.red, lineWidth: 2)
            .aspectRatio(16/9, contentMode: .fit)
            .border(Color.gray, width: 1)
            .padding()
            .onAppear {
                withAnimation(.easeOut) {
                    didAnimate.toggle()
                }
            }
    }
    
    init(data: [Double]) {
        self.data = data
    }
}

struct LineGraph: Shape {
    var data: [Double]
    
    func path(in rect: CGRect) -> Path {
        func point(at index: Int) -> CGPoint {
            let point = data[index]
            
            let x = rect.width * CGFloat(index) / CGFloat(data.count - 1)
            let y = (1 - point) * rect.height
            
            return CGPoint(x: x, y: y)
        }
        
        return Path { p in
            guard data.count > 1 else { return }
            
            let start = data[0]
            p.move(to: CGPoint(x: 0, y: (1 - start) * rect.height))
            for index in data.indices {
                p.addLine(to: point(at: index))
            }
        }
    }
    
    init(data: [Double]) {
        self.data = data.map { $0 / data.max()! }
    }
}

struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        LineGraphView(data: [1, 3, 5, 6, 2, 6, 7, 4, 8, 3])
    }
}
