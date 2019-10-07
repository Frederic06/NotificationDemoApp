//
//  TabCoordinator.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

enum ViewControllerItem: Int {
    case research = 0
    case favorites = 1
}

protocol TabCoordinatorType {
    var items: [UINavigationController] { get set }
}

final class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

final class TabCoordinator: NSObject, TabCoordinatorType {
    
    // MARK: - Properties
    private var presenter: UIWindow
    
    private var tabBarController: UITabBarController
    
    private var screens: Screens
    
    private var researchCoordinator: SearchCoordinator?
    
    private var favoritesCoordinator: FavoriteCoordinator?
    
    var items: [UINavigationController] = [
        CustomNavigationController(nibName: nil, bundle: nil),
        CustomNavigationController(nibName: nil, bundle: nil)
    ]
    
    // MARK: - Initializer

    init(presenter: UIWindow) {
        self.presenter = presenter

        screens = Screens()

        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        
        super.init()
        
        buildItems(with: screens)
        
        configureTabBar()
        UITabBarItem.appearance().setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 15.0)! ], for: .normal)
        tabBarController.viewControllers = self.items
        //The first view is Translator
        tabBarController.selectedViewController  = self[.research]
        
        tabBarController.delegate = self
    }
    
    // MARK: - Start
    
    func start() {
        presenter.rootViewController = tabBarController
        showResearch()
    }
    
    // MARK: - Private
    
    private func showResearch() {
        researchCoordinator = SearchCoordinator(presenter: self[.research] as! UINavigationController, screens: screens)
        researchCoordinator?.start()
    }
    
    private func showFavorites() {
        favoritesCoordinator = FavoriteCoordinator(presenter: self[.favorites] as! UINavigationController, screens: screens)
        favoritesCoordinator?.start()
    }
    
    private func buildItems(with screens: Screens) {
        items[0].tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 0)
        items[1].tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
    }
    
    private func configureTabBar() {
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.1147654131, green: 0.6290749311, blue: 0.9507474303, alpha: 1)
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        items[0].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        items[0].tabBarItem.image = UIImage(systemName: "doc.text.magnifyingglass")
        items[1].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        items[1].tabBarItem.image = UIImage(systemName: "heart.circle")
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        // We get the index, and we check if its exists
        let index = tabBarController.selectedIndex
        guard index < self.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Index out of range 🔥")
        }
        
        // We call the methods belonging to the index
        switch item {
        case .research:
            showResearch()
        case .favorites:
            showFavorites()
        }
    }
}

extension TabCoordinator {
    // subscript rewrites the behavior of index of our "item" array, we pass an element of the ViewControllerItem (an enumeration) and return a UIViewController
    
    subscript(item: ViewControllerItem) -> UIViewController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exists")
            }
            return items[item.rawValue]
        }
    }
}
