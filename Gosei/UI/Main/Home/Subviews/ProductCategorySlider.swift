//
//  ProductCategorySlider.swift
//  Gosei
//
//  Created by Bruno Benčević on 22.01.2022..
//

import SwiftUI

struct ProductCategorySlider: View {
    
    @Binding var currentCategory: ProductCategory
    
    var body: some View {
        ZStack(alignment: .bottom) {
            slider
            
            HStack(alignment: .bottom, spacing: 0) {
                tabButtons
                
                Spacer()
                
                categoryTitle
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .aspectRatio(1.75, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private extension ProductCategorySlider {
    
    var slider: some View {
        TabView(selection: $currentCategory) {
            ForEach(ProductCategory.allCases) { category in
                Image("\(category)_slider", bundle: .productCategoriesAssets)
                    .resizable()
                    .scaledToFill()
                    .tag(category)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    var tabButtons: some View {
        HStack(spacing: 8) {
            ForEach(ProductCategory.allCases) { category in
                Circle()
                    .fill((category == currentCategory ? Color.black : Color.gray241).opacity(0.8))
                    .transition(.opacity)
                    .frame(size: 10)
            }
        }
    }
    
    var categoryTitle: some View {
        let words = currentCategory.name.components(separatedBy: " ")
        
        return VStack(alignment: .trailing) {
            ForEach(words, id: \.self) { word in
                Text(word)
                    .padding(.horizontal, 5)
                    .background(Color.background.opacity(0.8))
            }
            .font(.playfair(20, .bold))
        }
    }
}

struct ProductCategorySlider_Previews: PreviewProvider {
    static var previews: some View {
        ProductCategorySlider(currentCategory: .constant(.kitchenAppliances))
    }
}
