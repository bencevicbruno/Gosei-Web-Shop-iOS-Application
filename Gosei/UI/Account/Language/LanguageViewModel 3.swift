//
//  LanguageViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import Foundation

final class LanguageViewModel: ObservableObject {
    
    var persistenceService: PersistenceServiceProtocol
    
    var onDismissed: EmptyCallback?
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    var selectedLanuage: PersistenceData.Language {
        persistenceService.langauge
    }
}

// MARK: - Interaction
extension LanguageViewModel {
    
    func languageTapped(_ language: PersistenceData.Language) {
        self.onDismissed?()
    }
}

// MARK: - Navigation
extension LanguageViewModel {
 
    func dismiss() {
        self.onDismissed?()
    }
}
