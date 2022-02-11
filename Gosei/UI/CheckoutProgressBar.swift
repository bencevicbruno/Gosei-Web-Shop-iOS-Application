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
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(size: 35)
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
        .frame(height: 80)
        .contentShape(Rectangle())
        .onChange(of: step) { newStep in
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
    }
}

private extension CheckoutProgressBar {
    
    var imageName: String {
        switch (self.iconStep) {
        case .shipping: return "icon_truck"
        case .billing: return "icon_creditCard"
        case .done: return "icon_checkMark"
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
            .fill(filled ? .black : .white)
            .overlay(Circle().stroke(.white, lineWidth: 3))
            .padding(3)
            .overlay(Circle().stroke(.black, lineWidth: 1))
            .frame(size: 40)
    }
}

struct CheckoutProgressBar_Previews: PreviewProvider {
    
    static var step: CheckoutProgressBar.Step = .shipping
    
    static var previews: some View {
        let binding = Binding<CheckoutProgressBar.Step>(
            get: {
                return Self.step
            }, set: { value in
                Self.step = value
            })
        CheckoutProgressBar(binding)
    }
}
