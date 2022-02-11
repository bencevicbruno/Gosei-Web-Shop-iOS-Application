//
//  LocationService.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import Foundation
import CoreLocation
import Combine

final class LocationService: NSObject {
    
    @Published var currentLocation: String = "Unknown"
    @Published var currentCoordinates: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    
    private var manager = CLLocationManager()
    private var geocoder = CLGeocoder()
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.currentCoordinates = location.coordinate
        self.currentLocation = "an unknwon place"
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let location = placemarks?.first?.name else { return }
            
            self?.currentLocation = location
        }
    }
}
