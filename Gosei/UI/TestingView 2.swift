//
//  TestingView.swift
//  Gosei
//
//  Created by Bruno Benčević on 26.01.2022..
//

import SwiftUI

struct TestingView: View {
    
    @State private var step: CheckoutProgressBar.Step = .shipping
    
    var body: some View {
        CheckoutProgressBar($step)
            .onTapGesture {
                step = .allCases.randomElement()!
            }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}
