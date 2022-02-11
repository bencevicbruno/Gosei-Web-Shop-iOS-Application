//
//  MainViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published var isHamburgerMenuVisible = false
    @Published var isTabBarbVisible = true
    @Published private(set)var currentTab: Tab = .home
    @Published var isSignOutDialogVisible = false
    
    var homeViewModel = HomeViewModel()
    var searchViewModel = SearchViewModel()
    var wishlistViewModel = WishlistViewModel()
    var cartViewModel = CartViewModel()
    
    var goToCategories: EmptyCallback?
    var goToAccount: ((PersistenceData.User) -> Void)?
    var goToSignOut: EmptyCallback?
    var goToCategory: ((ProductCategory) -> Void)?
    var goToProduct: ((Product) -> Void)?
    var onRedraw: EmptyCallback?
    
    var user: PersistenceData.User
    @Published var refreshToken = true
    @Published var interactionEnabled = true
    
    let items = ["Home", "Categories", "Search", "Wishlist", "Cart", "Account", "Sign Out"]
    
    private var lastTab: Tab = .home
    
    init(user: PersistenceData.User) {
        self.user = user
        setupCallbacks()
    }
    
    func toggleHamburgerMenu() {
        withAnimation {
            isHamburgerMenuVisible.toggle()
        }
    }
    
    func refresh() {
        refreshToken.toggle()
    }
    
    func switchTo(tab: Tab) {
        lastTab = currentTab
        currentTab = tab
    }
    
    func showAccountSheet() {
        self.goToAccount?(user)
    }
    
    func itemTapped(_ item: HamburgerMenuItem) {
        withAnimation {
            isHamburgerMenuVisible.toggle()
        }
        
        switch(item) {
        case .home:
            switchTo(tab: .home)
        case .categories:
            goToCategories?()
        case .search:
            switchTo(tab: .search)
        case .wishlist:
            switchTo(tab: .wishlist)
        case .cart:
            switchTo(tab: .cart)
        case .account:
            showAccountSheet()
        case .signOut:
            signOutTapped()
        }
    }
    
    func signOutTapped() {
        withAnimation {
            isSignOutDialogVisible = true
        }
    }
    
    func signOutConfirm() {
        PersistenceService().user = nil
        self.goToSignOut?()
    }
    
    func signOutCancel() {
        withAnimation {
            isSignOutDialogVisible = false
        }
    }
}

private extension MainViewModel {
    
    func setupCallbacks() {
        homeViewModel.onScroll = { [weak self] direction in
            self?.isTabBarbVisible = direction == .up
        }
        
        homeViewModel.onGoToProduct = { [weak self] product in
            self?.goToProduct?(product)
        }
        
        homeViewModel.onGoToCategory = { [weak self] category in
            self?.goToCategory?(category)
        }
        
        homeViewModel.onGoToCategories = { [weak self] in
            self?.goToCategories?()
        }
        
        searchViewModel.onDismissed = { [weak self] in
            guard let self = self else { return }
            self.switchTo(tab: self.lastTab)
        }
        
        wishlistViewModel.onScroll = { [weak self] direction in
            self?.isTabBarbVisible = direction == .up
        }
        
        cartViewModel.onScroll = { [weak self] direction in
            self?.isTabBarbVisible = direction == .up
        }
    }
}
