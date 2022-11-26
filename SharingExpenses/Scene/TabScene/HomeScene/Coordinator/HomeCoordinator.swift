//
//  HomeCoordinator.swift
//  SharingExpenses
//
//  Created by Alireza on 8/15/1401 AP.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    
    weak var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    let navProtocol: NavProtocol
    init(navigationController: UINavigationController, navProtocol: NavProtocol) {
        self.navigationController = navigationController
        self.navProtocol = navProtocol
    }
    
    func start() {
//        let homeController: HomeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let homeController: HomeVC = HomeVC.instantiate(.Home )
        homeController.homeCoordinator = self
        navigationController.pushViewController(homeController, animated: true)
    }
    
    func navToUsers() {
        navProtocol.navToUsers(isEditMode: true)
    }
    
    func rotateToSpends() {
        navProtocol.rotateToSpends()
    }
    
    deinit {
        print("removed \(self) from memory")
    }
}
