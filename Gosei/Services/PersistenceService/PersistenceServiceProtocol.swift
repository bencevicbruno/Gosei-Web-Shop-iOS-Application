//
//  PersistenceServiceProtocol.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import Foundation

protocol PersistenceServiceProtocol: AnyObject {
    
    var user: PersistenceData.User? { get set }
    var langauge: PersistenceData.Language? { get set }
    var colorScheme: PersistenceData.ColorScheme { get set }
    
    var useLightMode: Bool { get }
    var useDarkMode: Bool { get }
}
