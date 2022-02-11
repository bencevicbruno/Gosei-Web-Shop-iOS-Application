//
//  AppDelegate.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.11.2021..
//

import UIKit
import Fusion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupFusionContainer()
        
        return true
    }
    
    func setupFusionContainer() {
        Container.bind(.singleton, to: PersistenceServiceProtocol.self, value: PersistenceService())
    }
}
