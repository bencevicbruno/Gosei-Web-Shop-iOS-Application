//
//  ExternalLoginButton.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.11.2021..
//

import SwiftUI

struct ExternalLoginButton: View {
    
    private var style: Style
    private var size: CGFloat
    private var onTapped: EmptyCallback?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.white)
            
            style.image
                .resizable()
                .scaledToFit()
                .frame(size: self.size / 2)
        }
        .frame(size: self.size)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
        .onTapGesture {
            onTapped?()
        }
    }
    
    init(_ style: Style, size: CGFloat = 40, onTapped: EmptyCallback? = nil) {
        self.style = style
        self.size = size
        self.onTapped = onTapped
    }
}

extension ExternalLoginButton {
    
    enum Style {
        case google
        case facebook
        case apple
        
        var image: Image {
            Image("\(self)_logo")
        }
        
        var url: URL {
            URL(string: "https://www.\(self).com")!
        }
    }
}

struct ExternalLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        ExternalLoginButton(.google)
            .background(Color.black.opacity(0.1))
    }
}
