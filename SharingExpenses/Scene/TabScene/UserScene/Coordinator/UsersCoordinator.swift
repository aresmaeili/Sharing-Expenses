//
//  UsersCoordinator.swift
//  SharingExpenses
//
//  Created by Alireza on 8/15/1401 AP.
//

import Foundation
import UIKit

class UsersCoordinator: Coordinator {
    
    weak var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let usersVC = UIStoryboard(name: "Users", bundle: nil).instantiateViewController(withIdentifier: "UserManagerViewController") as! UserManagerViewController
        let usersVC =  UserManagerViewController.instantiate(.Users)
        usersVC.coordinator = self
        navigationController.pushViewController(usersVC, animated: true)
    }
    
    func navToUsers(isEditMode: Bool) {
//        let usersVC = UIStoryboard(name: "Users", bundle: nil).instantiateViewController(withIdentifier: "UserManagerViewController") as! UserManagerViewController
        let usersVC = UserManagerViewController.instantiate(.Users)
        usersVC.coordinator = self
        usersVC.isEdit = isEditMode
        usersVC.hidesBottomBarWhenPushed = isEditMode
        navigationController.pushViewController(usersVC, animated: true)
    }
    
    func popEditUser(delegate: NewUserViewControlerDelegate) {
//        let usersVC = UIStoryboard(name: "NewUser", bundle: nil).instantiateViewController(withIdentifier: "NewUserViewControler") as! NewUserViewControler
        let usersVC = NewUserViewControler.instantiate(.NewUser)
        usersVC.coordinator = self
        usersVC.delegate = delegate
        navigationController.pushViewController(usersVC, animated: true)
    }
    
    deinit {
        print("removed \(self) from memory")
    }
}
