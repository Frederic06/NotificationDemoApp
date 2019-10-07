//
//  FavoriteCoordinator.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 03/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//
import UIKit

final class FavoriteCoordinator{
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Public methods
    
    func start() {
        showSearch()
    }
    
    func showSearch() {
        let viewController = screens.createTwitterSearchViewController(persistence: .favorite, delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    func showDetail(tweet: TweetItem) {
        let viewController = screens.createTweetDetailViewController(tweet: tweet, delegate: self)
        presenter.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private methods
    
    private func showAlert(for type: AlertType) {
        guard let alert = screens.createAlert(for: type) else {return}
            if let popoverController = alert.popoverPresentationController {
          popoverController.sourceView = presenter.view
          popoverController.sourceRect = CGRect(x: presenter.view.bounds.midX, y: presenter.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

    // MARK: - Extensions

extension FavoriteCoordinator: TweetSearcViewModelDelegate {
    func locationRequest() {}
    
    func displayAlert(type: AlertType) {
        showAlert(for: type)
    }
    
    func didPresstweet(tweet: TweetItem) {
        showDetail(tweet: tweet)
    }
}

extension FavoriteCoordinator: TweetDetailViewModelDelegate {
    func displayAlarm(type: AlertType) {
        showAlert(for: type)
    }
}
