//
//  CategoryView.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.01.2022..
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject var viewModel: CategoryViewModel
    
    var body: some View {
        NotImplementedView(title: viewModel.category.name, onDismissed: viewModel.dismiss)
            .navigationBarHidden(true)
    }
}

private extension CategoryView {
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(viewModel: .init(category: .appleDevices))
    }
}
