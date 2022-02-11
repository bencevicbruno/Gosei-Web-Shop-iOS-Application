//
//  ModalModifiers.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.02.2022..
//

import Foundation
import SwiftUI

extension View {
    
    func confirmationAlert(isShowing: Bool, title: String, description: String? = nil, confirmTitle: String = Localizable.confirm.localized.capitalized, cancelTitle: String = Localizable.cancel.localized.capitalized, onDismissed: EmptyCallback? = nil, onConfirmed: EmptyCallback? = nil) -> some View {
        ZStack(alignment: .center) {
            self
            
            ConfirmationAlertView(title: title, description: description, confirmTitle: confirmTitle, cancelTitle: cancelTitle, onDismissed: onDismissed, onConfirmed: onConfirmed, offset: isShowing ? 0 : UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .isHidden(!isShowing)
                .allowsHitTesting(isShowing)
        }
    }
}
