//
//  MainHeaderView.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.01.2022..
//

import SwiftUI

struct MainHeaderView: View {
    
    @Binding var isHamburgerMenuVisible: Bool
    private var onAvatarTapped: EmptyCallback?
    
    var body: some View {
        HStack {
            HamburgerButton(isHamburgerMenuVisible: $isHamburgerMenuVisible)
            .frame(size: 35)
            .padding(.trailing, 20)
            
            Image.goseiLogo
                .resizable()
                .scaledToFit()
                .frame(height: 35)
            
            Spacer()
            
            Image.avatar
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .clipShape(Circle())
                .onTapGesture {
                    onAvatarTapped?()
                }
        }
        .padding(.horizontal, 12)
        .frame(height: Self.height)
        .background(Color.white)
    }
    
    init(isHamburgerMenuVisible: Binding<Bool>, onAvatarTapped: EmptyCallback? = nil) {
        self._isHamburgerMenuVisible = isHamburgerMenuVisible
        self.onAvatarTapped = onAvatarTapped
    }
    
    static let height: CGFloat = 45
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView(isHamburgerMenuVisible: .constant(true))
            .background(Color.lightGray)
    }
}
