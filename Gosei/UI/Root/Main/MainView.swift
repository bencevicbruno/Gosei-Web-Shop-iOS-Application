//
//  MainView.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.01.2022..
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            MainHeaderView(isHamburgerMenuVisible: $viewModel.isHamburgerMenuVisible, avatarURL: viewModel.user.avatarURL) { [weak viewModel] in
                viewModel?.showAccountSheet()
            }
            
            ZStack(alignment: .top) {
                content
                
                tabBar
                    .padding(.bottom, 10)
                
                ZStack(alignment: .topLeading) {
                    BlurredView(.regular)
                        .opacity(viewModel.isHamburgerMenuVisible ? 1.0 : 0.0)
                        .ignoresSafeArea()
                    
                    HamburgerMenu(isVisible: $viewModel.isHamburgerMenuVisible, viewModel: viewModel)
                }
            }
        }
        .background(Color.background)
        .foregroundColor(Color.text)
        .navigationBarHidden(true)
        .confirmationAlert(isShowing: viewModel.isSignOutDialogVisible, title: Localizable.sign_out.localized, description: Localizable.sign_out_message.localized, confirmTitle: Localizable.sign_out.localized ,onDismissed: viewModel.signOutCancel, onConfirmed: viewModel.signOutConfirm)
        .disabled(!viewModel.interactionEnabled)
        .id(viewModel.refreshToken ? 0 : 1)
    }
}

private extension MainView {
    
    var content: some View {
        switch(viewModel.currentTab) {
        case .home:
            return AnyView(HomeView(viewModel: viewModel.homeViewModel))
        case .search:
            return AnyView(SearchView(viewModel: viewModel.searchViewModel))
        case .wishlist:
            return AnyView(WishlistView(viewModel: viewModel.wishlistViewModel))
        case .cart:
            return AnyView(CartView(viewModel: viewModel.cartViewModel))
        }
    }
    
    var tabBar: some View {
        VStack {
            Spacer()
            
            TabBarView(currentTab: viewModel.currentTab, onSwitchTo: { [weak viewModel] newTab in
                viewModel?.switchTo(tab: newTab)
            })
                .shadow(radius: 5)
                .offset(x: 0, y: viewModel.isTabBarbVisible ? 0 : 2 * TabBarView.height)
            
        }
        .padding(.horizontal, 10)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(user: .sample))
            .previewDevices(.iphoneSE2, .iPhoneSE, .iPhone13)
    }
}
