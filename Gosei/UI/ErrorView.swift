//
//  ErrorView.swift
//  Gosei
//
//  Created by Bruno Benčević on 20.01.2022..
//

import SwiftUI

// NOTE: Make another view for testing the error view for
// each case, meaning if any of the below items are optional
// since making it when unwrapping optionals takes too long.

struct ErrorView: View {
    
    var title: String
    var description: String
    var imageName: String?
    var buttonTitle: String?
    var buttonCallback: EmptyCallback? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            image
                .padding(.bottom, 25)
            
            titleLabel
                .padding(.horizontal, 20)
            
            descriptionLabel
                .padding(.horizontal, 20)
            
            if let buttonTitle = buttonTitle {
                Spacer()
                
                actionButton(buttonTitle)
                
                Spacer()
            }
            
            Spacer()
        }
    }
    
    init(title: String, description: String, imageName: String? = nil) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.buttonTitle = nil
        self.buttonCallback = nil
    }
    
    init(title: String, description: String, imageName: String? = nil, buttonTitle: String, buttonCallback: EmptyCallback? = nil) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.buttonTitle = buttonTitle
        self.buttonCallback = buttonCallback
    }
}

private extension ErrorView {
    
    var image: some View {
        (imageName != nil ? Image(imageName!) : Image(systemName: "xmark.octagon"))
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
    }
    
    var titleLabel: some View {
        Text(title)
            .font(.playfair(24, .bold))
            .multilineTextAlignment(.center)
    }
    
    var descriptionLabel: some View {
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

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: "Error", description: "Here lies a giant error message that nobody is gonna read but here we are..", imageName: "avatar", buttonTitle: "Vule je kriv")
        
        ErrorView(title: "Error", description: "a ša ćeš", imageName: "avatar", buttonTitle: "Vule je kriv")
        
        ErrorView(title: "Error", description: "Here lies a giant error message that nobody is gonna read but here we are..")
    }
}
