//
//  Coordinator.swift
//  SharingExpenses
//
//  Created by Setare Yek on 10/23/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var parentCoordinators: Coordinator? { get }
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    
    func start()
}
