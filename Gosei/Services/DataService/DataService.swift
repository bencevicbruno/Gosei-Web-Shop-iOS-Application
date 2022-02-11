//
//  DataService.swift
//  Gosei
//
//  Created by Bruno Benčević on 03.01.2022..
//

import Foundation
import Combine

final class DataService: DataServiceProtocol {
    
    func fetch<T>(from url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .tryCatch { _ in 
                return Empty<T, Never>()
            }
            .eraseToAnyPublisher()
    }
}
