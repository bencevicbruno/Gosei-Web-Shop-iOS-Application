//
//  WishlistProductCard.swift
//  Gosei
//
//  Created by Bruno Benčević on 23.01.2022..
//

import SwiftUI

struct WishlistProductCard: View {
    
    var product: WishlistProduct
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
                
                favoriteIcon
            }
            
            productName
                .padding(.top, 15)
        }
        .padding(10)
        .background(Color.backgroundAccent)
        .foregroundColor(Color.text)
    }
}

private extension WishlistProductCard {
    
    var favoriteIcon: some View {
        Image(product.isFavorite ? .icon_heart_filled : .icon_heart)
            .resizable()
            .scaledToFit()
            .frame(size: 15)
            .padding(2.5)
    }
    
    var productName: some View {
        Text(product.name)
            .font(.playfair(18, .bold))
            .multilineTextAlignment(.center)
    }
    
}

struct WishlistProductCard_Previews: PreviewProvider {
    static var previews: some View {
        WishlistProductCard(product: .init(name: "Hehe", imageName: "test_iPhone", isFavorite: true))
        
        WishlistProductCard(product: .init(name: "a very long name should go in here hehe", imageName: "test_iPhone", isFavorite: false))
    }
}
