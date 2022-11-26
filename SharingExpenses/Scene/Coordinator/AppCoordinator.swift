//
//  MainCoordinator.swift
//  SharingExpenses
//
//  Created by Setare Yek on 10/23/22.
//

import Foundation
import UIKit

class AppCoordinator: NSObject {
    var rootViewController: UIViewController?
    var childCoordinators: [NSObject] = []
    var navigationController: UINavigationController
    let window: UIWindow

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    func start() {
        showHomeScreen()
    }
    func showHomeScreen() {
        rootViewController = UITabBarController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        let tabCoordinator = TabCoordinator(navigationController: navigationController, tabBarController: (rootViewController as? UITabBarController)!)
        childCoordinators.append(tabCoordinator)
        tabCoordinator.start()
    }
}
