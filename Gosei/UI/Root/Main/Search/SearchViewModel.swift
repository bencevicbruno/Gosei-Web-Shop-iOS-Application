//
//  SearchViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import Foundation
import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var contentState: State = .initial
    
    var onDismissed: EmptyCallback?
    
    private var subscribers = Set<AnyCancellable>()
    private var searchResults = [String]()
    
    init() {
        setupSubscribers()
    }
    
    func dismiss() {
        subscribers.removeAll()
        searchText = ""
        contentState = .initial
        self.onDismissed?()
    }
    
    enum State {
        case initial
        case loading
        case loaded(results: [String])
        case error(message: String)
    }
}

private extension SearchViewModel {
    
    func setupSubscribers() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                guard searchText.count != 0 else { return }
                self?.contentState = .loading
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int.random(in: 2...4))) { [weak self] in
                    let chance = Float.random(in: 0...1)
                    
                    if (0..<0.3).contains(chance) {
                        self?.contentState = .error(message: "Something happened")
                    } else if (0.3..<0.6).contains(chance) {
                        self?.contentState = .loaded(results: [])
                    } else {
                        let results = (1...10).reduce(into: [String]()) { result, number in
                            result.append("search result #\(number)")
                        }
                        self?.contentState = .loaded(results: results)
                    }
                }
            }
            .store(in: &subscribers)
    }
}

extension SearchViewModel {
    
    // MARK: - For previews
    
    convenience init(state: State) {
        self.init()
        self.searchText = "search text"
        self.contentState = state
    }
}
