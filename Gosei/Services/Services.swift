//
//  Services.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.02.2022..
//

import Foundation

final class Services: ServicesProtocol {
    
    static let shared: ServicesProtocol = Services()
    
    var persistenceService: PersistenceServiceProtocol
    
    private init() {
        persistenceService = PersistenceService()
    }
}
