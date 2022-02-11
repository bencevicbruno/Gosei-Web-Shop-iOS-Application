//
//  UserDefaults+.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import Foundation

extension UserDefaults {
    
    static func load<T>(key: PersistenceData.Key) -> T? where T: Decodable {
        guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else { return nil }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    static func save<T>(_ t: T, key: PersistenceData.Key) where T: Encodable {
        guard let data = try? JSONEncoder().encode(t) else { return }
        
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
}
