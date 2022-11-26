//
//  ViewController.swift
//  SharingExpenses
//
//  Created by Alireza on 8/23/1401 AP.
//

import Foundation
import UIKit

class ViewController: UIViewController, Storyboarded {

    deinit {
        print("🔴 Removed \(self) from MEMORY 🔴")
    }
    
}

protocol Storyboarded {
    static func instantiate(_ storyboard: StoryboardName) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboard: StoryboardName) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = storyboard.instance

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

enum StoryboardName: String {
    case Home
    case Spends
    case Users
    case Events
    case NewSpend
    case NewUser
    case NewEvent
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
