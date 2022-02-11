//
//  HomeView.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            ProductCategorySlider(currentCategory: $viewModel.currentSliderCategory)
            
            promotionalProducts
            
            largeButton("CHECK ALL LATEST")
                .padding(.vertical, 30)
            
            categories
            
            largeButton("BROWSE ALL CATEGORIES", onTapped: viewModel.browseAllCategoriesTapped)
                .padding(.vertical, 30)
        }
        .gesture(DragGesture().onChanged(viewModel.onDragged))
        .padding(.horizontal, 10)
        .onAppear { [weak viewModel] in
            viewModel?.objectWillChange.send()
        }
    }
}

// MARK: - Components
private extension HomeView {
    
    func largeButton(_ text: String, onTapped: EmptyCallback? = nil) -> some View {
        Text(text)
            .font(.workSans(18, .semiBold))
            .background(Color.background)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(Color.background)
            .padding(2)
            .background(Color.text)
            .contentShape(Rectangle())
            .onTapGesture {
                onTapped?()
            }
    }
}

// MARK: - Subcomponents
private extension HomeView {
    
    var promotionalProducts: some View {
        VStack(spacing: 0) {
            HStack {
                Text(Localizable.promotional_products.localized)
                    .font(.playfair(24, .bold))
                    .foregroundColor(Color.text)
                    .padding(.bottom, 20)
                
                Spacer()
            }
            
            LazyVGrid(columns: .twoColumns) {
                ForEach(viewModel.promotionalProducts) { product in
                    PromotionalProductCard(product: product)
                        .onTapGesture {
                            viewModel.productTapped(product)
                        }
                }
            }
        }
    }
    
    var categories: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Shop by Categories")
                    .font(.playfair(24, .bold))
                    .foregroundColor(Color.text)
                    .padding(.bottom, 20)
                
                Spacer()
            }
            
            LazyVGrid(columns: .twoColumns) {
                ForEach(viewModel.promotionalCategories) { category in
                    ProductCategoryCard(category, onTapped: viewModel.categoryTapped)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
