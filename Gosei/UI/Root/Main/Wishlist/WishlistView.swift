//
//  WishlistView.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import SwiftUI

struct WishlistView: View {
    
    @ObservedObject var viewModel: WishlistViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: .twoColumns) {
                ForEach(viewModel.products) { product in
                    WishlistProductCard(product: product)
                }
            }
            
            line
                .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity)
        .gesture(DragGesture().onChanged(viewModel.onDragged))
        .padding(.horizontal, 10)
        .background(Color.background)
        .foregroundColor(Color.text)
    }
}

private extension WishlistView {
    
    var line: some View {
        Rectangle()
            .frame(height: 1)
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView(viewModel: WishlistViewModel())
    }
}
