//
//  TextSeparator.swift
//  Gosei
//
//  Created by Bruno Benčević on 02.12.2021..
//

import SwiftUI

struct TextSeparator: View {
    private var text: String
    private var color: Color
    private var orientation: TextSeparator.Orientation
    
    var body: some View {
        if orientation == .normal || orientation == .upsideDown {
            horizontalSeparator
        } else {
            verticalSeparator
        }
    }
    
    init(_ text: String, color: Color = .lightGray, orientation: Orientation = .normal) {
        self.text = text
        self.color = color
        self.orientation = orientation
    }
}

private extension TextSeparator {
    var horizontalSeparator: some View {
        HStack(alignment: .center) {
            Rectangle()
                .fill(color)
                .frame(height: 2)
            
            Text(Localizable.or.localized.uppercased())
                .foregroundColor(color)
                .rotationEffect(.degrees(orientation == .upsideDown ? 180 : 0))
            
            Rectangle()
                .fill(color)
                .frame(height: 2)
        }
    }
    
    var verticalSeparator: some View {
        VStack(alignment: .center) {
            Rectangle()
                .fill(color)
                .frame(width: 2)
            
            Text(Localizable.or.localized.uppercased())
                .foregroundColor(color)
                .rotationEffect(.degrees(orientation == .leading ? 90 : -90))
            
            Rectangle()
                .fill(color)
                .frame(width: 2)
        }
    }
}

extension TextSeparator {
    enum Orientation {
        case normal
        case upsideDown
        case leading
        case trailing
    }
}

struct TextSeparator_Previews: PreviewProvider {
    static var previews: some View {
        TextSeparator("TEST")
        TextSeparator("TEST", orientation: .upsideDown)
        TextSeparator("TEST", orientation: .leading)
    }
}
