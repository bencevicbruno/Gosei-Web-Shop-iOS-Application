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
            MainHeaderView(isHamburgerMenuVisible: $viewModel.isHamburgerMenuVisible) {
                viewModel.showAccountSheet()
            }
            
            ZStack(alignment: .topLeading) {
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
        .navigationBarHidden(true)
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
            
            TabBarView(currentTab: viewModel.currentTab, onSwitchTo: viewModel.switchTo)
                .shadow(radius: 5)
                .offset(x: 0, y: viewModel.isTabBarbVisible ? 0 : 2 * TabBarView.height)
            
        }
        .padding(.horizontal, 10)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(user: .sample))
    }
}
