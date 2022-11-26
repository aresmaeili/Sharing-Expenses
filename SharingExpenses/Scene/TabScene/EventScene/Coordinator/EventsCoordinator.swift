//
//  EventsCoordinator.swift
//  SharingExpenses
//
//  Created by Alireza on 8/15/1401 AP.
//

import Foundation
import UIKit

class EventsCoordinator: Coordinator {
    
    weak var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let eventsVC = UIStoryboard(name: "Events", bundle: nil).instantiateViewController(withIdentifier: "EventManagerViewController") as! EventManagerViewController
        let eventsVC = EventManagerViewController.instantiate(.Events)
        eventsVC.coordinator = self
        navigationController.pushViewController(eventsVC, animated: true)
    }
    
    func navToEvents(isEdit: Bool) {
//        let vc = UIStoryboard(name: "Events", bundle: nil).instantiateViewController(withIdentifier: "EventManagerViewController") as! EventManagerViewController
        let vc = EventManagerViewController.instantiate(.Events)
        vc.coordinator = self
        vc.hidesBottomBarWhenPushed = isEdit
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popEditEvent(delegate: NewEventViewControllerDelegate) {
//        let vc = UIStoryboard(name: "NewEvent", bundle: nil).instantiateViewController(withIdentifier: "NewEventViewController") as! NewEventViewController
        let vc = NewEventViewController.instantiate(.NewEvent)
        vc.coordinator = self
        vc.delegate = delegate
        navigationController.pushViewController(vc, animated: true)
    }
    
    deinit {
        print("removed \(self) from memory")
    }
}
