//
//  ProductCategoryCard.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.01.2022..
//

import SwiftUI

struct ProductCategoryCard: View {
    
    private var category: ProductCategory
    private var cornerRadius: CGFloat
    private var onTapped: ((ProductCategory) -> Void)?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(category.imageName)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Text(category.name)
                .font(.playfair(16, .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .padding(cornerRadius)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .aspectRatio(0.75, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .contentShape(RoundedRectangle(cornerRadius: cornerRadius))
        .onTapGesture {
            onTapped?(category)
        }
    }
    
    init(_ category: ProductCategory, cornerRadius: CGFloat = 4.0, onTapped: ((ProductCategory) -> Void)? = nil) {
        self.category = category
        self.cornerRadius = cornerRadius
        self.onTapped = onTapped
    }
}

struct ProductCategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCategoryCard(.appleDevices)
    }
}
