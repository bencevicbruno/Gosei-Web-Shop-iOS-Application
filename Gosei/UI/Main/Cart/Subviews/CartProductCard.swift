//
//  CartProductCard.swift
//  Gosei
//
//  Created by Bruno Benčević on 26.01.2022..
//

import SwiftUI

struct CartProductCard: View {
    
    var product: Product
    var minusTapped: EmptyCallback
    var plusTapped: EmptyCallback
    
    var body: some View {
        HStack(spacing: 0) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(size: 100)
                .padding(10)
                .shadow(radius: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(product.name)
                    .font(.playfair(20, .bold))
                
                Text("Vacuum cleaner")
                    .font(.workSans(14, .regular))
                
                Text("\(product.price)")
                    .font(.workSans(18, .bold))
            }
            .padding(10)
            
            VStack(alignment: .trailing, spacing: 0) {
                actionIndicator
                
                Spacer()
                
                amountStepper(product: product)
            }
            .padding(.all.subtracting(.trailing).subtracting(.top), 10)
        }
        .frame(height: 100)
        .padding(.vertical, 20)
    }
}

private extension CartProductCard {
    
    var actionIndicator: some View {
        Image("icon_triangleRight_filled")
            .resizable()
            .scaledToFit()
            .frame(size: 20)
    }
    
    func amountStepper(product: Product) -> some View {
        HStack(spacing: 0) {
            ZStack {
                Rectangle()
                
                Text("-")
                    .font(.workSans(16, .medium))
                    .foregroundColor(.white)
            }
            
            ZStack {
                Rectangle()
                    .fill(.white)
                    .border(.black, width: 1)
                
                Text("1")
                    .font(.workSans(16, .medium))
            }
            
            ZStack {
                Rectangle()
                
                Text("+")
                    .font(.workSans(16, .medium))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 75, height: 25)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct CartProductCard_Previews: PreviewProvider {
    static var previews: some View {
        CartProductCard(product: .test, minusTapped: {}, plusTapped: {})
    }
}
