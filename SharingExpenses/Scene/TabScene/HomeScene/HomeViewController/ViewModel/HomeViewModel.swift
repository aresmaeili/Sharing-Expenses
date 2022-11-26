//
//  HomeViewModel.swift
//  SharingExpenses
//
//  Created by Alireza on 8/18/1401 AP.
//

import Foundation

struct HomeViewModel {
    
    private var events: Events { DataManager.shared.events }
    private var users: Users { DataManager.shared.users }
    private var spends: Spends { DataManager.shared.spends }
    
    var allSpendsAmopunt: Int {
        spends.reduce(0, {$0 + $1.amount})
    }
    
    var usersCount: Int {
        users.count
    }
    var eventsCount: Int {
        events.count
    }
    
    func numberofRowsInSection(_ type: CollectionType) -> Int {
        switch type {
        case .users:
            return users.count
        case .events:
            return events.count
        default:
            fatalError()
        }
    }
    
    func userForRow(indexPath: IndexPath) -> User {
        users[indexPath.row]
    }
    
    func eventsForRow(indexPath: IndexPath) -> Event {
        events[indexPath.row]
    }
}
