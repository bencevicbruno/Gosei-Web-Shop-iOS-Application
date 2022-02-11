//
//  LocationViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import Foundation
import Combine
import CoreLocation

final class LocationViewModel: ObservableObject {
    
    @Published var currentLocation = "Unknown"
    @Published var currentCoordinates = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // alternative: manually creating publishers
    // use-case: dynamic arrays of publishers
    // ie: bluetooth chars
    
//    let currentLocationPublisher = CurrentValueSubject<String, Never>("Unknown")
//    private var currentLocationToPublish = "Unknown" {
//        didSet {
//            currentLocationPublisher.send("newValue")
//        }
//    }
    
    private var locationService = LocationService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
}

private extension LocationViewModel {
    
    func setupSubscribers() {
        locationService.$currentLocation
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] location in
                self?.currentLocation = location
            }
            .store(in: &cancellables)
        
        locationService.$currentCoordinates
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] coordinates in
                self?.currentCoordinates = coordinates
            }
            .store(in: &cancellables)
    }
}
