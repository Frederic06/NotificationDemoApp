//
//  ApplicationCoordinator.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 03/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class AppCoordinator {

    // MARK: - Properties
    
    private let presenter: UIWindow
    
    private var tabCoordinator: TabCoordinator!

    // MARK: - Init
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }

    // MARK: - Coordinator

    func start() {
        showTab()
    }
    
    private func showTab() {
        tabCoordinator = TabCoordinator(presenter: presenter)
        tabCoordinator.start()
    }
}
