//
//  SpendsCoordinator.swift
//  SharingExpenses
//
//  Created by Alireza on 8/15/1401 AP.
//

import Foundation
import UIKit
import FittedSheets

class SpendsCoordinator: Coordinator {
    
    weak var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    let navProtocol: NavProtocol
    init(navigationController: UINavigationController, navProtocol: NavProtocol) {
        self.navigationController = navigationController
        self.navProtocol = navProtocol
    }
    
    func start() {
//        let spendsVC = UIStoryboard(name: "Spends", bundle: nil).instantiateViewController(withIdentifier: "SpendsViewController") as! SpendsViewController
        let spendsVC = SpendsViewController.instantiate(.Spends)
        spendsVC.coordinator = self
        navigationController.pushViewController(spendsVC, animated: true)
    }
    
    func navToEvents(delegate: NewEventViewControllerDelegate) {
        //        TODO: read this
//        // navProtocol.navToEvents()
//        let eventsCoordinator: EventsCoordinator = EventsCoordinator(navigationController: navigationController)
//        childCoordinators.append(eventsCoordinator)
//        eventsCoordinator.parentCoordinators = self
//        eventsCoordinator.navToEvents(isEdit: true)
//        let editSpendsVC = UIStoryboard(name: "NewEvent", bundle: nil).instantiateViewController(withIdentifier: "NewEventViewController") as! NewEventViewController
//        editSpendsVC.coordinator = self

        let editSpendsVC = NewEventViewController.instantiate(.NewEvent)
        editSpendsVC.hidesBottomBarWhenPushed = true
        editSpendsVC.delegate = delegate
        navigationController.dismiss(animated: true)
        navigationController.pushViewController(editSpendsVC, animated: true)
    }
    
    func navToUsers(delegate: NewUserViewControlerDelegate) {
        //        TODO: read this
//        let usersCoordinator: UsersCoordinator = UsersCoordinator(navigationController: navigationController)
//        childCoordinators.append(usersCoordinator)
//        usersCoordinator.parentCoordinators = self
//        usersCoordinator.navToUsers(isEditMode: true)
        
//        let editSpendsVC = UIStoryboard(name: "NewUser", bundle: nil).instantiateViewController(withIdentifier: "NewUserViewControler") as! NewUserViewControler

        let editSpendsVC = NewUserViewControler.instantiate(.NewUser)
        editSpendsVC.delegate = delegate
        navigationController.dismiss(animated: true)
        editSpendsVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(editSpendsVC, animated: true)
    }
    
    func popEditSpendView(delegate: NewSpendViewControllerDelegate) {
//        let editSpendsVC = UIStoryboard(name: "NewSpend", bundle: nil).instantiateViewController(withIdentifier: "NewSpendViewController") as! NewSpendViewController
        
    #warning("bargardoonam ino")
//
//        let editSpendsVC = NewSpendViewController.instantiate(.NewSpend)
//        editSpendsVC.coordinator = self
//        editSpendsVC.delegate = delegate
//        editSpendsVC.hidesBottomBarWhenPushed = true
//        navigationController.pushViewController(editSpendsVC, animated: true)
        //
        let editSpendsVC = NewSpendViewController.instantiate(.NewSpend)
                editSpendsVC.coordinator = self
        editSpendsVC.delegate = delegate
        editSpendsVC.hidesBottomBarWhenPushed = true

        let sheetController = SheetViewController(
            controller: editSpendsVC,
            sizes: [.fixed(700)])
        navigationController.present(sheetController, animated: true)
        
    }
    
    deinit {
        print("removed \(self) from memory")
    }
}
