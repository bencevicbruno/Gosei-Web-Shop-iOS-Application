//
//  CheckoutProgressBar.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import SwiftUI

struct CheckoutProgressBar: View {
    
    @Binding var step: Step
    @State private var iconStep: Step
    @State private var circleStep: Step
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 5) {
                iconImage
                    .resizable()
                    .scaledToFit()
                    .frame(size: 30)
                    .offset(x: imageOffset(proxy), y: 0)
                    .transition(.slide)
                
                HStack(spacing: 0) {
                    circle(filled: true)
                    
                    line
                    
                    circle(filled: circleStep.rawValue >= 1)
                        .transition(.opacity)
                    
                    line
                    
                    circle(filled: circleStep.rawValue >= 2)
                        .transition(.opacity)
                }
                .transition(.opacity)
            }
        }
        .frame(height: 60)
        .contentShape(Rectangle())
        .onChange(of: step) { _ in
            performAnimation()
        }
    }
    
    init(_ binding: Binding<Step>) {
        self._step = binding
        self.iconStep = binding.wrappedValue
        self.circleStep = binding.wrappedValue
    }
}

extension CheckoutProgressBar {
    
    enum Step: Int, CaseIterable {
        case shipping = 0
        case billing = 1
        case done = 2
        
        var title: String {
            switch(self) {
            case .shipping: return Localizable.shipping_details.localized
            case .billing: return Localizable.payment_details.localized
            case .done: return Localizable.payment_successful.localized
            }
        }
    }
}

private extension CheckoutProgressBar {
    
    var iconImage: Image {
        switch (self.iconStep) {
        case .shipping: return Image(.icon_truck)
        case .billing: return Image(.icon_creditCard)
        case .done: return Image(.icon_checkMark)
        }
    }
    
    func imageOffset(_ proxy: GeometryProxy) -> CGFloat {
        switch (self.iconStep) {
        case .shipping: return 0
        case .billing: return (proxy.size.width - 35) / 2
        case .done: return proxy.size.width - 35
        }
    }
    
    func performAnimation() {
        let animationDuration = 1.0
        
        if step.rawValue < iconStep.rawValue { // going left
            withAnimation(.linear(duration: animationDuration / 2)) {
                circleStep = step
            }
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                iconStep = step
            }
            
        } else { // going right
            withAnimation(.easeInOut(duration: animationDuration)) {
                iconStep = step
            }
            
            withAnimation(.linear(duration: animationDuration / 2).delay(animationDuration * 2 / 3)) {
                circleStep = step
            }
        }
    }
    
    var line: some View {
        Rectangle()
            .frame(height: 4)
    }
    
    func circle(filled: Bool) -> some View {
        Circle()
            .fill(filled ? Color.text : Color.background)
            .overlay(Circle().stroke(Color.background, lineWidth: 3))
            .padding(3)
            .overlay(Circle().stroke(Color.text, lineWidth: 1))
            .frame(size: 30)
    }
}

struct CheckoutProgressBar_Previews: PreviewProvider {
    
    static var previews: some View {
        CheckoutProgressBar(.constant(.shipping))
    }
}
