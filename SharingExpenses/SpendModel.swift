//
//  Model.swift
//  SharingExpenses
//
//  Created by Setare Yek on 10/24/22.
//

import Foundation
 
struct Spend {
    private(set) var  id: Int
    var title: String
    var amount: Int
    var owner: User
    var users: Users
    var event: Event
    
    init(title: String, amount: Int, owner: User, users: [User] = [], event: Event) {
        self.id = UUID().hashValue
        self.title = title
        self.amount = amount
        self.owner = owner
        self.users = users
        self.event = event
    }
}

extension Spend: Equatable {
    static func == (lhs: Spend, rhs: Spend) -> Bool {
        lhs.id == rhs.id
    }

}

extension Spend {
    
    mutating func addUser(users: User...) {
        self.users.append(contentsOf: users)
    }
}

extension Spends {
    
    func getUserEventAcount(_ event: Event, _ user: User) -> Debt {
        let EventCost = getEventCost(event, user)
        let EventSpend = getEventSpend(event, user)
        return (EventCost, EventSpend)
    }
    
    func getEventCost(_ event: Event, _ user: User) -> Int {
        let filteredCosts = filter({$0.event.id == event.id})
        let filteredSpendsWithoutOwnerUser = filteredCosts.filter({$0.owner.id != user.id})
        let totalCost = filteredSpendsWithoutOwnerUser.reduce(0) {$0 + $1.amount}
        return totalCost
    }
    
    func getEventSpend(_ event: Event, _ user: User) -> Int {
        let filteredSpends = filter({$0.event.id == event.id})
        let filteredSpendsByUser = filteredSpends.filter({$0.owner.id == user.id})
        let totalSpend = filteredSpendsByUser.reduce(0, {$0 + $1.amount})
        return totalSpend
    }
    var totalSpends: Int {
        reduce(0, {$0+$1.amount})
    }
    
    func number0fRowsInSection (_ section: Int) -> Int {
        DataManager.shared.spendsCount
    }
    
    func articleAtIndex (_ index: Int) -> Spend {
        DataManager.shared.spends[index]
    }
}

//
// extension Spends {
//
//    func getUserEventAcount(_ event: Event , _ user: User) -> Debt {
//        let EventCost = getEventCost(event, user)
//        let EventSpend = getEventSpend(event, user)
//        return (EventCost,EventSpend)
//    }
//
//    func getEventCost(_ event: Event , _ user: User) -> Int{
//        let filteredCosts = self.filter({$0.event.id == event.id})
//        let filteredSpendsWithoutOwnerUser = filteredCosts.filter({$0.owner.id != user.id})
//        let totalCost = filteredSpendsWithoutOwnerUser.reduce(0) {$0 + $1.amount}
//        return totalCost
//    }
//
//    func getEventSpend(_ event: Event , _ user: User) -> Int {
//        let filteredSpends = self.filter({$0.event.id == event.id})
//        let filteredSpendsByUser = filteredSpends.filter({$0.owner.id == user.id})
//        let totalSpend = filteredSpendsByUser.reduce(0, {$0 + $1.amount})
//        return totalSpend
//    }
//    var totalSpends: Int {
//        self.reduce(0, {$0+$1.amount})
//    }
// }
