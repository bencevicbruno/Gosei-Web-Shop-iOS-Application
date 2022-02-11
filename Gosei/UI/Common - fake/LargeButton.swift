//
//  LargeButton.swift
//  Gosei
//
//  Created by Bruno Benčević on 02.12.2021..
//

import SwiftUI

struct LargeButton: View {
    private var title: String
    private var color: Color
    private var style: LargeButton.Style
    private var onTapped: EmptyCallback?
    
    var body: some View {
        ZStack {
            background
                .frame(height: 60)
            
            Text(title)
                .font(.workSans(24, .extraBold))
        }
        .onTapGesture {
            onTapped?()
        }
    }
    
    init(_ title: String, color: Color = .goseiRed, style: LargeButton.Style = .filled, _ onTapped: EmptyCallback? = nil) {
        self.title = title
        self.color = color
        self.style = style
        self.onTapped = onTapped
    }
    
    private var background: AnyView {
        if style == .filled {
            return AnyView(
                RoundedRectangle(cornerRadius: 10)
                .fill(color))
        } else {
            return AnyView(Rectangle()
                .fill(.white)
                .padding(2)
                .background(Color.goseiDark))
        }
    }
}

extension LargeButton {
    enum Style {
        case filled
        case bordered
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            LargeButton("Test Title")
            LargeButton("Test Title", style: .bordered)
        }
    }
}
