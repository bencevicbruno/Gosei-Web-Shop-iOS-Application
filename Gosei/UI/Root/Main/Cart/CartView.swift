//
//  CartView.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        NotImplementedView()
            .gesture(DragGesture().onChanged(viewModel.onDragged))
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel())
    }
}
