//
//  ServicesProtocol.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.02.2022..
//

import Foundation

protocol ServicesProtocol: AnyObject {
    
    var persistenceService: PersistenceServiceProtocol { get }
}

