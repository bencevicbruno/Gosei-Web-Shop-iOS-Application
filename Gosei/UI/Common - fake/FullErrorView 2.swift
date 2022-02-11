//
//  FullErrorView.swift
//  Gosei
//
//  Created by Bruno Benčević on 21.01.2022..
//

import SwiftUI

struct FullErrorView: View {
    
    var title: String
    var description: String
    var imageName: String
    var buttonTitle: String
    var buttonCallback: EmptyCallback? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            image(imageName)
                .padding(.bottom, 25)
            
            titleLabel
                .padding(.horizontal, 20)
            
            descriptionLabel(description)
                .padding(.horizontal, 20)
            
            Spacer()
            
            actionButton(buttonTitle)
            
            Spacer()
            
            Spacer()
        }
    }
}

private extension FullErrorView {
    
    func image(_ imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
    }
    
    var titleLabel: some View {
        Text(title)
            .font(.playfair(24, .bold))
            .multilineTextAlignment(.center)
    }
    
    func descriptionLabel(_ description: String) -> some View {
        Text(description)
            .font(.workSans(16, .regular))
            .multilineTextAlignment(.center)
    }
    
    func actionButton(_ title: String) -> some View {
        Text(title)
            .font(.workSans(20, .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 4).frame(height: 40))
            .onTapGesture {
                self.buttonCallback?()
            }
    }
}

struct FullErrorView_Previews: PreviewProvider {
    static var previews: some View {
        FullErrorView(title: "Error", description: "Here lies a giant error message that nobody is gonna read but here we are..", imageName: "avatar", buttonTitle: "VULE JE KRIV")
    }
}
