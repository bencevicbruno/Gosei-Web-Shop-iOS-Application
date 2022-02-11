//
//  HamburgerView.swift
//  Gosei
//
//  Created by Bruno Benčević on 30.11.2021..
//

import SwiftUI
import Combine

struct HamburgerMenu: View {
    
    @Binding var isVisible: Bool
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            BlurredView(.regular)
                .opacity(isVisible ? 1.0 : 0.0)
                .ignoresSafeArea()
            
            menu
                .offset(x: isVisible ? 0 : -Self.width, y: 0)
        }
    }
    
    static let width: CGFloat = 300
}

private extension HamburgerMenu {
    
    var menu: some View {
        VStack(alignment: .leading) {
            ForEach(HamburgerMenuItem.allCases) { item in
                rowCard(item)
            }
        }
        .padding(.horizontal, 12)
        .frame(width: 300)
        .background(Color.white)
    }
    
    func rowCard(_ item: HamburgerMenuItem) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(item.title)
                .font(.playfair(24, .extraBold))
            
            Rectangle()
                .frame(height: 1)
                .padding(.top, 10)
                .padding(.bottom, 12)
        }
        .onTapGesture {
            viewModel.itemTapped(item)
        }
    }
}

struct HamburgerMenu_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerMenu(isVisible: .constant(true), viewModel: MainViewModel(user: .sample))
    }
}
