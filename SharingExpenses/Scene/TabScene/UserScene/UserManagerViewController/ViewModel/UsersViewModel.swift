//
//  UsersViewModel.swift
//  SharingExpenses
//
//  Created by Alireza on 8/17/1401 AP.
//

import Foundation

struct UsersViewModel {
    
    var events: Events { DataManager.shared.events }
    var users: Users { DataManager.shared.users }
    var spends: Spends { DataManager.shared.spends }

    var usersCount: Int { users.count }
    var usersTotalSpend: Int {
        events.getEventsCost.reduce(0, {$0+$1.cost})
    }
    
    func setNew(name: String?, phone: String?) {
        DataManager.shared.setNew(user: User(name: name ?? "Unknown", phone: phone ?? "Unknown"))
    }
    
    func getUsersEvents() -> [(user: User, events: Events)] {
        var useer: [(user: User, events: Events)] = []
        for user in DataManager.shared.users {
            let user = user
            var events: Events = []
            for spend in DataManager.shared.spends {
                let spendd = spend.users.compactMap({$0.id})
                if spendd.contains(user.id) {
                    events.append(spend.event)
                }
            }
            useer.append((user: user, events: events))
        }
        return useer
    }
    
    func number0fRowsInSection (_ section: Int) -> Int {
        DataManager.shared.usersCount
    }
    
    func articleAtIndex (_ index: Int) -> User {
        DataManager.shared.users[index]
    }
    
    func getUserForRow(indexPath: IndexPath) -> User {
        users[indexPath.row]
    }
}
