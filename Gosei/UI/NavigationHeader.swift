//
//  NavigationHeader.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import SwiftUI

struct NavigationHeader: View {
    
    private var title: String
    private var onDismiss: EmptyCallback?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image.icon_arrowLeft
                    .resizable()
                    .scaledToFit()
                    .frame(size: 30)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onDismiss?()
                    }
                
                Spacer(minLength: 10)
                
                Text(title)
                    .font(.playfair(24, .bold))
                
                Spacer(minLength: 10)
            }
            .padding(.trailing, 30)
            .frame(height: 50)
            .padding(.horizontal, 10)
            
            Rectangle()
                .frame(height: 2)
                .padding(.horizontal, 40)
        }
        .background(Color.background)
        .foregroundColor(Color.text)
    }
    
    init(title: String, onDismiss: EmptyCallback? = nil) {
        self.title = title
        self.onDismiss = onDismiss
    }
}

struct NavigationHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeader(title: "Test Title")
    }
}
