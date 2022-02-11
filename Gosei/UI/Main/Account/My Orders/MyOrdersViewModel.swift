//
//  MyOrdersViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import Foundation

final class MyOrdersViewModel: ObservableObject {
    
    var onDismissed: EmptyCallback?
    
    init() {
        
    }
}

// MARK: - Navigation
extension MyOrdersViewModel {
    
    func dismiss() {
        self.onDismissed?()
    }
}
