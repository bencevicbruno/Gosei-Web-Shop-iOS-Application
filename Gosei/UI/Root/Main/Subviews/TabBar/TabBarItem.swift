//
//  TabBarItem.swift
//  Gosei
//
//  Created by Bruno Benčević on 29.11.2021..
//

import SwiftUI

struct TabBarItem: View {
    
    private var tab: Tab
    private var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            tab.image
                .resizable()
                .scaledToFit()
                .frame(size: 20)
                .shadow(radius: isSelected ? 5 : 0)
                .padding(.top, self.isSelected ? 10 : 0)
            
            if self.isSelected {
                Text(tab.title.uppercased())
                    .font(.workSans(10, .medium))
                    .foregroundColor(Color.text)
            }
        }
    }
    
    init(_ mainTab: Tab, isSelected: Bool = false) {
        self.tab = mainTab
        self.isSelected = isSelected
    }
}

struct MainTabBarIcon_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            TabBarItem(.cart, isSelected: true)
            TabBarItem(.search, isSelected: false)
        }
    }
}
