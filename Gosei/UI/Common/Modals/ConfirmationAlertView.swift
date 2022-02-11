//
//  ConfirmationAlertView.swift
//  Gosei
//
//  Created by Bruno Benčević on 02.02.2022..
//

import SwiftUI

struct ConfirmationAlertView: View {
    
    var title: String
    var description: String?
    var confirmTitle: String
    var cancelTitle: String
    var onDismissed: EmptyCallback?
    var onConfirmed: EmptyCallback?
    var offset: CGFloat
    
    var body: some View {
        ZStack(alignment: .center) {
            BlurredView(.light)
                .onTapGesture {
                    onDismissed?()
                }
            
            VStack(alignment: .center, spacing: 15) {
                Text(title)
                    .font(.playfair(18, .bold))
                    .multilineTextAlignment(.center)
                
                if let description = description {
                    Text(description)
                        .font(.workSans(16, .regular))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)
                }
                
                HStack(spacing: 0) {
                    Text(cancelTitle)
                        .font(.workSans(16, .medium))
                        .padding(.horizontal, 15)
                        .frame(width: 120, height: 40)
                        .onTapGesture {
                            onDismissed?()
                        }
                    
                    Text(confirmTitle)
                        .font(.workSans(16, .medium))
                        .foregroundColor(Color.background)
                        .padding(.horizontal, 15)
                        .frame(width: 120, height: 40)
                        .background(Capsule().fill(Color.text))
                        .onTapGesture {
                            onConfirmed?()
                        }
                }
            }
            .foregroundColor(Color.text)
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .frame(maxWidth: 300)
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.background))
            .offset(x: 0, y: offset)
        }
    }
    
    init(title: String, description: String? = nil, confirmTitle: String, cancelTitle: String, onDismissed: EmptyCallback? = nil, onConfirmed: EmptyCallback? = nil, offset: CGFloat = .zero) {
        self.title = title
        self.description = description
        self.confirmTitle = confirmTitle
        self.cancelTitle = cancelTitle
        self.onDismissed = onDismissed
        self.onConfirmed = onConfirmed
        self.offset = offset
    }
}

struct ConfirmationAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .center) {
            Image("kitchenAppliances_slider", bundle: .productCategoriesAssets)
                .resizable()
                .scaledToFill()
            
            ConfirmationAlertView(title: "Sign Out", description: "Are you sure you want to sign out?", confirmTitle: "Confirm", cancelTitle: "Cancel")
        }
        .ignoresSafeArea()
        .previewDevices(.iPhoneSE, .iPhone13)
    }
}
