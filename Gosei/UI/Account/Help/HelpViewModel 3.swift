//
//  HelpViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import Foundation

final class HelpViewModel: ObservableObject {
    
    @Published var message: String = ""
    @Published var email: String = ""
    
    var onDismissed: EmptyCallback?
    
    init() {
        
    }
}

// MARK: - Interaction
extension HelpViewModel {
    
    func sendTapped() {
        self.onDismissed?()
    }
}

// MARK: - Navigation
extension HelpViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
}
