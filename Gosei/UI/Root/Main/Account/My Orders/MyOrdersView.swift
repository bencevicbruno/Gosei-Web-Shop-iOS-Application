//
//  MyOrdersView.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import SwiftUI

struct MyOrdersView: View {
    
    @ObservedObject var viewModel: MyOrdersViewModel
    
    var body: some View {
        NotImplementedView(title: "My Orders", onDismissed: viewModel.dismiss)
            .navigationBarHidden(true)
    }
}

struct MyOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersView(viewModel: .init())
    }
}
