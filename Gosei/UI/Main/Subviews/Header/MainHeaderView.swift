//
//  MainHeaderView.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.01.2022..
//

import SwiftUI

struct MainHeaderView: View {
    
    @Binding var isHamburgerMenuVisible: Bool
    private var avatarURL: URL?
    private var onAvatarTapped: EmptyCallback?
    
    var body: some View {
        HStack {
            HamburgerButton(isHamburgerMenuVisible: $isHamburgerMenuVisible)
                .frame(size: 35)
                .padding(.trailing, 20)
            
            Image(.gosei_logo)
                .resizable()
                .scaledToFit()
                .frame(height: 35)
            
            Spacer()
            
            avatar
        }
        .padding(.horizontal, 12)
        .frame(height: Self.height)
        .background(Color.background)
    }
    
    init(isHamburgerMenuVisible: Binding<Bool>, avatarURL: URL? = nil, onAvatarTapped: EmptyCallback? = nil) {
        self._isHamburgerMenuVisible = isHamburgerMenuVisible
        self.avatarURL = avatarURL
        self.onAvatarTapped = onAvatarTapped
    }
    
    static let height: CGFloat = 45
}

private extension MainHeaderView {
    
    var avatar: some View {
        AsyncImage(url: avatarURL) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(size: 35)
        } placeholder: {
            Image(.icon_avatar)
                .resizable()
                .scaledToFit()
                .frame(size: 35)
        }
        .clipShape(Circle())
        .contentShape(Circle())
        .onTapGesture {
            onAvatarTapped?()
        }
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView(isHamburgerMenuVisible: .constant(true))
            .background(Color.lightGray)
    }
}
