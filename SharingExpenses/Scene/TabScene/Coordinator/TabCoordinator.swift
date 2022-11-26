//
//  TabCoordinator.swift
//  Coordinator
//
//  Created by Nikola on 28/02/2018.
//  Copyright © 2018 Ingemark. All rights reserved.
//

import Foundation
import UIKit

class TabCoordinator: NSObject, Coordinator {
    
    weak var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController
    
    lazy var homeCoordinator: HomeCoordinator = {
        HomeCoordinator(navigationController: UINavigationController(), navProtocol: self)
    }()
    lazy var spendsCoordinator: SpendsCoordinator = {
        SpendsCoordinator(navigationController: UINavigationController(), navProtocol: self)
    }()
    lazy var usersCoordinator: UsersCoordinator = {
        UsersCoordinator(navigationController: UINavigationController())
    }()
    lazy var eventsCoordinator: EventsCoordinator = {
        EventsCoordinator(navigationController: UINavigationController())
    }()
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        
        var controllers: [UIViewController] = []
        
        homeCoordinator.start()
        spendsCoordinator.start()
        eventsCoordinator.start()
        usersCoordinator.start()
        
        let homeViewController = homeCoordinator.navigationController
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homekit"), selectedImage: nil)
        homeViewController.tabBarItem.image = UIImage(systemName: "homekit")?.withRenderingMode(.alwaysOriginal)
        childCoordinators.append(homeCoordinator)
        
        let eventsViewController = eventsCoordinator.navigationController
        eventsViewController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(systemName: "calendar.badge.clock.rtl"), selectedImage: nil)
        childCoordinators.append(eventsCoordinator)
        
        let usersViewController = usersCoordinator.navigationController
        usersViewController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person"), selectedImage: nil)
        childCoordinators.append(usersCoordinator)
        
        let spendsViewController = spendsCoordinator.navigationController
        spendsViewController.tabBarItem = UITabBarItem(title: "Spends", image: UIImage(systemName: "dollarsign.arrow.circlepath"), selectedImage: nil)
        childCoordinators.append(spendsCoordinator)
        
        controllers.append(homeViewController)
        controllers.append(spendsViewController)
        controllers.append(eventsViewController)
        controllers.append(usersViewController)

        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.tabBar.isTranslucent = true
        tabBarController.delegate = self
        }
    
    deinit {
        print("removed \(self) from memory")
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    
}

extension TabCoordinator: NavProtocol {
    func rotateToHome() {
        tabBarController.selectedIndex = 0
    }
    func rotateToSpends() {
        tabBarController.selectedIndex = 1
    }
    func rotateToEvents() {
        tabBarController.selectedIndex = 2
    }
    func rotateTousers() {
        tabBarController.selectedIndex = 3
    }
    
    func navToEvents() {
        rotateToEvents()
        eventsCoordinator.navToEvents(isEdit: false)
    }
    
    func navToUsers(isEditMode: Bool) {
        rotateTousers()
        usersCoordinator.navToUsers(isEditMode: isEditMode)
    }
}

protocol NavProtocol {
    func rotateToHome()
    func rotateToSpends()
    func rotateToEvents()
    func rotateTousers()
    func navToEvents()
    func navToUsers(isEditMode: Bool)
}
