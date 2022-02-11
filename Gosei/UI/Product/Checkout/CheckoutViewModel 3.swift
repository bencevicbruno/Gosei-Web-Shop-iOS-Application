//
//  CheckoutViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.02.2022..
//

import Foundation

final class CheckoutViewModel: ObservableObject {
    
    @Published var step: CheckoutProgressBar.Step = .shipping
    
    @Published var adress = ""
    @Published var streetNumber = ""
    @Published var country = ""
    
    @Published var name = ""
    @Published var cardNumber = ""
    @Published var expirationMonth = ""
    @Published var expirationYear = ""
    @Published var cvv = ""
    @Published var instalments = ""
    
    var onXTapped: EmptyCallback?
    var onReturnToHomePageTapped: EmptyCallback?
    
    init() {
        
    }
    
    init(step: CheckoutProgressBar.Step) {
        self.step = step
    }
}

// MARK: - Interaction
extension CheckoutViewModel {
    
    func backTapped() {
        self.step = .shipping
    }
    
    func xTapped() {
        self.onXTapped?()
    }
    
    func checkoutTapped() {
        self.step = .billing
    }
    
    func confirmTapped() {
        self.step = .done
    }
    
    func returnToHomePageTapped() {
        self.onReturnToHomePageTapped?()
    }
}
