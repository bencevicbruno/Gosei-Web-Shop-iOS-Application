//
//  LineGraphView.swift
//  Gosei
//
//  Created by Bruno Benčević on 11.02.2022..
//

import SwiftUI

struct LineGraphView: View {
    
    let data = [ 40.0,
                 51.0, 50.0, 50.0, 48.0, 47.0, 48.0, 59.0,
                 64.0, 64.0, 64.0, 64.0, 64.0, 64.0, 64.0,
                 64.0, 64.0, 64.0, 64.0, 64.0, 64.0, 64.0,
                 64.0, 64.0, 64.0, 64.0, 64.0, 64.0, 64.0,
                 64.0, 64.0, 64.0, 64.0, 64.0, 64.0, 64.0,
                 64.0, 64.0, 64.0, 64.0, 64.0, 64.0, 64.0,
                 52.0, 51.0, 49.0, 50.0, 49.0, 49.0, 48.0,
                 47.0, 47.0, 47.0, 47.0, 49.0, 48.0, 49.0,
                 49.0, 49.0, 49.0, 48.0, 49.0, 49.0, 48.0,
                 49.0, 58.0, 62.0, 77.0, 80.0, 79.0, 78.0,
                 64.0, 64.0, 64.0, 64.0, 64.0, 64.0, 64.0,
                 71.0, 71.0, 68.0, 66.0, 67.0, 65.0, 58.0, 100.0,
                 57.0, 57.0, 56.0, 58.0, 57.0, 57.0, 55.0,
                 59.0, 57.0, 56.0, 55.0, 54.0, 53.0, 52.0,
                 51.0, 51.0, 51.0, 61.0, 61.0, 61.0, 60.0,
                 57.0, 56.0, 57.0, 54.0, 54.0, 54.0, 54.0]
    
    
    
    let fontSize: CGFloat = 20
    
    var dataMax: Double {
        data.max()!
    }
    
    var dataMin: Double {
        data.min()!
    }
    
    var body: some View {
        GeometryReader { geo in
            Image(uiImage: Dataset(data).drawGraph(in: CGRect(origin: .zero, size: geo.size)))
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
                .background(.blue.opacity(0.1))
        }
//        .aspectRatio(1.5, contentMode: .fit)
        .padding()
        .background(.blue.opacity(0.1))
    }
    
    var test: some View {
        GeometryReader { geoProxy in
            VStack(spacing: 0) {
                HStack(alignment: .bottom) {
                    markers(viewHeight: geoProxy.size.height)
                    
                    LineGraphShape(dataset: Dataset(data))
                        .stroke(Color(uiColor: .systemPink), lineWidth: 2)
                        .background(graphBackground.mask(LineGraphShape(dataset: Dataset(data), isMask: true)))
                        .padding(.vertical, fontSize / 2)
                }
                .padding()
                .background(Color.gray.opacity(0.25))
                
                Text("hehe")
            }
        }
        .aspectRatio(1.2, contentMode: .fit)
        .font(.system(size: fontSize))
    }
    
    var graphBackground: some View {
        let colors: [UIColor] = [
            .lightGray, .lightGray, .lightGray, .lightGray, .systemPink, .systemPink, .systemPink, .purple
        ]
        
        return LinearGradient(colors: colors.map { Color(uiColor: $0.withAlphaComponent(0.4)) }, startPoint: .top, endPoint: .bottom)
    }
    
    func markers(viewHeight: CGFloat) -> some View {
        VStack(spacing: 0) {
            ForEach(0..<(yAxisLabels(viewHeight: viewHeight).count)) { index in
                Text(yAxisLabels(viewHeight: viewHeight)[index])
                    .fontWeight(.medium)
                
                if index != yAxisLabels(viewHeight: viewHeight).count - 1 {
                    Spacer()
                }
            }
        }
    }
    
    func yAxisLabels(viewHeight: CGFloat) -> [String] {
        let numberOfMidValues = max(1, Int(viewHeight / (fontSize + 40)))
        let dataRange = dataMax - dataMin
        let step = dataRange / (Double(numberOfMidValues) + 1)
        
        var labels: [String] = ["\(dataMin)"]
        
        for i in 1...numberOfMidValues {
            labels.append(String(format: "%.2f", dataMin + step * Double(i)))
        }
        
        labels.append("\(dataMax)")
        
        return labels.reversed()
    }
    
//    func drawRectangle() {
//        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
//
//        let img = renderer.image { ctx in
//            // awesome drawing code
//        }
//
//        imageView.image = img
//    }
}


extension VerticalAlignment {
    struct XAxisAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let xAxisAlignment = VerticalAlignment(XAxisAlignment.self)
}

struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        LineGraphView()
            .frame(height: 400)
    }
}
