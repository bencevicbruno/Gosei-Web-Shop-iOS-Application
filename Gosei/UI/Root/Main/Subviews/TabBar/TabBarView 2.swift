//
//  TabBarView.swift
//  Gosei
//
//  Created by Bruno Benčević on 29.11.2021..
//

import SwiftUI

struct TabBarView: View {
    
    var currentTab: Tab
    var onSwitchTo: ((Tab) -> Void)?
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.white)
            
            HStack {
                ForEach(Tab.allCases) { tab in
                    TabBarItem(tab, isSelected: currentTab == tab)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            onSwitchTo?(tab)
                        }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: Self.height)
    }
    
    static var height: CGFloat = 65
    static var safeHeight: CGFloat = 65 + 2*10
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(currentTab: .home)
            .padding()
            .background(Color.lightGray)
    }
}
