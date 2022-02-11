//
//  HamburgerButton.swift
//  Gosei
//
//  Created by Bruno Benčević on 02.12.2021..
//

import SwiftUI

struct HamburgerButton: View {
    
    // MARK: - States
    @Binding var isHamburgerMenuVisible: Bool
    @State private var animationState = AnimationState.hamburger
    @State private var isInteractable = true
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .fill(Color.text)
                    .frame(height: lineHeight(geo))
                    .offset(x: 0, y: -outerLinesOffset(geo))
                    .rotationEffect(-angle)
                
                HStack {
                    Rectangle()
                        .fill(Color.text)
                        .frame(width: biggerLineWidth(geo), height: lineHeight(geo))
                    
                    Spacer(minLength: 0)
                    
                    Rectangle()
                        .fill(Color.text)
                        .frame(width: smallerLineWidth(geo), height: lineHeight(geo))
                }
                .rotationEffect(angle)
                
                Rectangle()
                    .fill(Color.text)
                    .frame(height: lineHeight(geo))
                    .offset(x: 0, y: outerLinesOffset(geo))
                    .rotationEffect(angle)
            }
            .frame(size: min(geo.size.width, geo.size.height))
        }
        .background(Color.background)
        .contentShape(Rectangle())
        .allowsHitTesting(isInteractable)
        .onTapGesture {
            withAnimation {
                isHamburgerMenuVisible.toggle()
            }
        }
        .onChange(of: isHamburgerMenuVisible) { newValue in
            toggleAnimation()
        }
    }
}

private extension HamburgerButton {
    
    // MARK: - Dimensions
    func biggerLineWidth(_ geo: GeometryProxy) -> CGFloat {
        return geo.size.width * 17/30
    }
    
    func smallerLineWidth(_ geo: GeometryProxy) -> CGFloat {
        return geo.size.width * 8/30
    }
    
    func lineHeight(_ geo: GeometryProxy) -> CGFloat {
        return (animationState == .cross ? 2 : 1.5) * geo.size.width / 15
    }
    
    func outerLinesOffset(_ geo: GeometryProxy) -> CGFloat {
        return animationState == .hamburger ? (geo.size.width / 6 + lineHeight(geo)) : 0
    }
    
    var angle: Angle{
        Angle.degrees(animationState == .cross ? 45 : 0)
    }
    
    // MARK: - Animations
    enum AnimationState: Equatable {
        case hamburger
        case line
        case cross
    }
    
    func toggleAnimation() {
        isInteractable = false
        
        let finalState: HamburgerButton.AnimationState = animationState == .cross ? .hamburger : .cross
        
        Self.animate {
            animationState = .line
        } then: {
            animationState = finalState
        } completion: {
            isInteractable = true
        }
    }
    
    // MARK: - Util
    
    static func animate(_ animation: @escaping () -> Void, then: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        let animationDuration = 0.15
        
        withAnimation(.linear(duration: animationDuration)) {
            animation()
        }
        
        withAnimation(.linear(duration: animationDuration).delay(animationDuration)) {
            then?()
        }
        
        let completionDelay = (then == nil ? 1 : 2) * animationDuration
        DispatchQueue.main.asyncAfter(deadline: .now() + completionDelay) {
            completion?()
        }
    }
}

// MARK: - Previews
struct HamburgerButton_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerButton(isHamburgerMenuVisible: .constant(true))
    }
}
