//
//  LanguageViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import Foundation
import Fusion

final class LanguageViewModel: ObservableObject {
    @Inject var persistenceService: PersistenceServiceProtocol
    
    @Published var selectedLanguage: PersistenceData.Language!
    
    var onDismissed: ((Bool) -> Void)?
    
    init(persistenceService: PersistenceServiceProtocol) {
        if let lang = persistenceService.langauge {
            selectedLanguage = lang
            return
        }
        
        guard let deviceLangCode = Locale.current.languageCode else {
            selectedLanguage = .english
            return
        }
        
        PersistenceData.Language.allCases.forEach { language in
            if language.rawValue == deviceLangCode {
                selectedLanguage = language
                return
            }
        }
        
        selectedLanguage = .english
    }
    
    deinit {
        print("aj bok")
    }
}

// MARK: - Interaction
extension LanguageViewModel {
    
    func dismiss() {
        self.onDismissed?(false)
    }
    
    func languageTapped(_ language: PersistenceData.Language) {
        persistenceService.langauge = language
        self.onDismissed?(true)
    }
}
