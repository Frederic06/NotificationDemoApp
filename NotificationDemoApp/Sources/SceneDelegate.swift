//
//  SceneDelegate.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 27/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
//    var coordinator: AppCoordinator!
    var coordinator: AppCoordinator!
    var window: UIWindow?

// UI Scene is the new top UI Object instead of Windows which used to be, and we now add our window to our UIScene
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        window!.makeKeyAndVisible()
        
        coordinator = AppCoordinator(presenter: window!)
        coordinator.start()
    }
}
