//
//  LineGraphView.swift
//  Gosei
//
//  Created by Bruno Benčević on 11.02.2022..
//

import SwiftUI

struct LineGraphView: View {
    
    private var data: [Double] = [11, 680, 200, 200, 200, 200, 200, 600, 600, 600, 600, 50, 60, 265, 6, 123, 40, 80, 323]
    
    @State private var didAnimate = false
    
    private var yMarkCount: Int
    
    var body: some View {
            HStack(spacing: 0) {
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(0..<dataMarks.count, id: \.self) { index in
                        Text("\(dataMarks[index], specifier: "%g")")
                            .frame(height: 20)
                        
                        if index != dataMarks.count - 1 {
                            Spacer()
                        }
                    }
                    .font(.system(size: 20))
                    .background(Color.gray.opacity(0.25))
                }
                .background(Color.gray.opacity(0.25))
                
                LineGraph(data: data, maxValue: dataMarks.first!)
                    .stroke(.red, lineWidth: 2)
                    .background(Color.gray.opacity(0.25))
                    .padding(.vertical, 10)
            }
        .padding()
    }
    
    func getHeight(_ proxy: GeometryProxy, index: Double) -> CGFloat {
        return CGFloat(index + 0.5 / Double(dataMarks.count) * proxy.size.height)
    }
    
    var stepValue: Double {
        switch(data.max()!) {
        case 0...50: return 5
        case 50...150: return 10
        case 200...300: return 20
        case 300...: return 100
        default: return 10
        }
    }
    
    var dataMarks: [Double] {
        var marks = [0.0]
        
        var currentStep = 0.0
        
        repeat {
            currentStep += stepValue
            marks.append(currentStep)
        } while currentStep < data.max()!
        
        return marks.reversed()
    }
    
    init(yMarkCount: Int) {
        self.yMarkCount = yMarkCount
    }
    
}

private extension LineGraphView {
    
    var yMaxMark: Int {
        switch (data.max()!) {
        case 0..<50: return 50
        case 50..<100: return 100
        case 100..<150: return 150
        case 150..<200: return 200
        case 200..<250: return 250
        case 250..<300: return 300
        default: return 50
        }
    }
}

struct LineGraph: Shape {
    var data: [Double]
    var isMask: Bool
    
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
            
            if isMask {
                p.addLine(to: CGPoint(x: rect.width, y: rect.height))
                p.addLine(to: CGPoint(x: 0, y: rect.height))
            }
        }
    }
    
    init(data: [Double], maxValue: Double, isMask: Bool = false) {
        self.data = data.map { $0 / maxValue}
        self.isMask = isMask
    }
}

struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        LineGraphView(yMarkCount: 10)
            .frame(height: 400)
    }
}
