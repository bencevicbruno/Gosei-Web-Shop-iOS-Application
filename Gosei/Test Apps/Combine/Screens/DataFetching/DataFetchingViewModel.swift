//
//  DataServiceViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import Foundation
import Combine
import SwiftUI

struct TVMazeResponse: Codable {
    
    let show: TVMazeShow
    
    struct TVMazeShow: Identifiable, Codable {
        let id: Int
        let name: String
    }
}

final class DataFetchingViewModel: ObservableObject {
    
    @Published var fetchDataWhileTyping = false
    @Published var keyword = ""
    @Published var searchResults: [TVMazeResponse.TVMazeShow] = []
    @Published var delayIndex = 0
    
    private var delays = [0.0, 0.1, 0.5, 1.0, 2.0, 5.0]
    
    private var dataService: DataServiceProtocol = DataService()
    private var cancellables = Set<AnyCancellable>()
    private var indexSubscriber: AnyCancellable?
    
    init() {
        setupSubscribers()
    }
    
    func fetchMovies() {
        guard let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(keyword)") else { return }
        
        dataService.fetch(from: url)
            .assertNoFailure()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completed in
                print("receiveCompletion \(completed)")
            }, receiveValue: { (response: [TVMazeResponse]) in
                print("receiveValue")
                self.searchResults = response.map { $0.show }
            })
            .store(in: &cancellables)
    }
}

extension DataFetchingViewModel {
    var delayTime: String {
        "\(delays[delayIndex])"
    }
    
    var delayIndexRange: ClosedRange<Int> {
        0...(delays.count - 1)
    }
}

private extension DataFetchingViewModel {
    func setupSubscribers() {
        indexSubscriber = self.$delayIndex.sink { [weak self] newIndex in
            self?.cancellables.forEach { $0.cancel() }
            self?.cancellables.removeAll()
            self?.setupFetchingSubscriber()
        }
    }
    
    func setupFetchingSubscriber() {
        self.$keyword
            .debounce(for: .seconds(delays[delayIndex]), scheduler: RunLoop.main)
            .sink { [weak self] _ in
            if self?.fetchDataWhileTyping ?? false {
                self?.fetchMovies()
            }
        }
        .store(in: &cancellables)
    }
}
