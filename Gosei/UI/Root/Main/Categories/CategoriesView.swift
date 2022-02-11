//
//  CategoriesView.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.01.2022..
//

import SwiftUI

struct CategoriesView: View {
    
    @ObservedObject var viewModel: CategoriesViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(title: "Categories", onDismiss: viewModel.dismiss)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: .twoColumns, spacing: 15) {
                    ForEach(ProductCategory.allCases) { category in
                        ProductCategoryCard(category, cornerRadius: 10, onTapped: viewModel.categoryTapped)
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.top, 20)
        }
        .background(Color.background)
        .foregroundColor(Color.text)
        .navigationBarHidden(true)
    }
}

private extension CategoriesView {
    
    func categoryCard(_ category: ProductCategory) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(category.imageName)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Text(category.name)
                .font(.playfair(16, .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .padding(5)
                .background(.black)
        }
        .aspectRatio(0.75, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .contentShape(RoundedRectangle(cornerRadius: 4))
        .onTapGesture {
            viewModel.categoryTapped(category)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(viewModel: .init())
    }
}
