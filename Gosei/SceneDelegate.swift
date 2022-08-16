//
//  SceneDelegate.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.11.2021..
//

import UIKit
import SwiftUI
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var rootCoordinator: RootCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
//        let navigationController = UINavigationController()
//        rootCoordinator = RootCoordinator(navigationController: navigationController)
//        rootCoordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIHostingController(rootView: LineGraphView())
        window?.makeKeyAndVisible()
    }
}
