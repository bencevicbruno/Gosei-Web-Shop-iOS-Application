//
//  DataServiceProtocol.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import Foundation
import Combine

protocol DataServiceProtocol {
    
    func fetch<T: Decodable>(from url: URL) -> AnyPublisher<T, Error>
}
