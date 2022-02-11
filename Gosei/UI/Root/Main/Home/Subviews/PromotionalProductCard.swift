//
//  PromotionalProductCard.swift
//  Gosei
//
//  Created by Bruno Benčević on 22.01.2022..
//

import SwiftUI

struct PromotionalProductCard: View {
    
    var product: Product
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack(alignment: .topTrailing) {
                    productImage(proxy)
                    
                    favoriteIcon
                        .padding(.trailing, 7)
                }
                .padding(.top, 5)
                
                productName
                    .padding(.top, 10)
                    .padding(.bottom, 15)
            }
            .background(Color.backgroundAccent)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .aspectRatio(0.8, contentMode: .fit)
    }
}

private extension PromotionalProductCard {
    
    func productImage(_ proxy: GeometryProxy) -> some View {
        HStack {
            Spacer()
            
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(size: imageSize(proxy))
            
            Spacer()
        }
    }
    
    var productName: some View {
        Text(product.name)
            .font(.playfair(18, .bold))
    }
    
    var favoriteIcon: some View {
        Image(product.isFavorite ? .icon_heart : .icon_heart_filled)
            .resizable()
            .scaledToFit()
            .frame(size: 20)
            .padding(5)
    }
}

private extension PromotionalProductCard {
    
    func imageSize(_ proxy: GeometryProxy) -> CGFloat {
        return proxy.size.width * 111 / 170
    }
}

struct PromotionalProductCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PromotionalProductCard(product: .test)
            
            PromotionalProductCard(product: .testFavorite)
        }
        .frame(width: 200)
    }
}
