//
//  SceneDelegate.swift
//  IntermediateTraining
//
//  Created by huygur on 29.11.2022.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let companiesController = CompaniesViewController()
            let navController = CustomNavigationController(rootViewController: companiesController)
            window.rootViewController = navController
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}

