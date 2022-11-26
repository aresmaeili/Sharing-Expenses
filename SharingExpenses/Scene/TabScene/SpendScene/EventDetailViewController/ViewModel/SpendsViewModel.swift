//
//  SpendViewModel.swift
//  SharingExpenses
//
//  Created by Alireza on 8/18/1401 AP.
//

import Foundation

protocol SpendViewModelDelegate {
    func dataChanged()
}

struct SpendViewModel {
    var delegate: SpendViewModelDelegate!
    
    var isEdit: Bool = false

//    private(set) var titlee: String = ""
//    private(set) var cost: Int = 0
    private(set) var selectedUsers: Users = [] {
        didSet {
            delegate?.dataChanged()
        }
    }
    private(set) var owner: User = User(name: "Unknown") {
        didSet {
            delegate?.dataChanged()
        }
    }
    var events: Events {
            DataManager.shared.events
    }
    
    var users: Users {
            DataManager.shared.users
        }
    
    var spends: Spends {
            DataManager.shared.spends
    }
    
    //    var allSpendsAmopunt: Int {
    //        spends.reduce(0, {$0 + $1.amount})
    //    }
    //
    var selectedEvent: Event = Event(title: "Unknown") {
        didSet {
            delegate?.dataChanged()
        }
    }
    
    var selectedUsersId: Users = []
    
    var spendsCount: Int {
        spends.count
    }
    var usersCount: Int {
        users.count
    }
    var eventsCount: Int {
        events.count
    }
    var totalSpend: Int {
        events.getEventsCost.reduce(0, {$0+$1.cost})
    }
    //    var owner: User {
    //        if let selectedOwner {
    //            return users[selectedOwner]
    //        }else{
    //            return User(name: "Unknown")
    //        }
    //    }
 
    func spendForRow(indexPath: IndexPath) -> Spend {
        spends[indexPath.row]
    }
    
    func spendsUsers(indexPath: IndexPath) -> Users {
        spends[indexPath.row].users
    }
    
    func spendsEvent(indexPath: IndexPath) -> Event {
        spends[indexPath.row].event
    }
    
    func spendsOwner(indexPath: IndexPath, selectedUsers: Users) -> User {
        selectedUsers[indexPath.row]
    }

    func numberofRowsInSection(_ type: CollectionType) -> Int {
        switch type {
        case .events:
            return eventsCount
        case .users:
            return usersCount
        // swiftlint:disable:next empty_enum_arguments
        case .owner(_):
            return selectedUsers.count
        }
    }
    
    func userForRow(indexPath: IndexPath, isOwner: Bool) -> User {
        isOwner ? selectedUsers[indexPath.row] :  users[indexPath.row]
    }
    
    func eventsForRow(indexPath: IndexPath) -> Event {
        events[indexPath.row]
    }
    
//    mutating func setSpend(spend: Spend) {
//        spends.append(spend)
//    }
    
//    mutating func setTitleCost(title: String, cost: Int) {
//        self.titlee = title
//        self.cost = cost
//    }
    
    mutating func setSelectedEvents(event: Event) {
        selectedEvent = event
    }
    
    mutating func setOwner(owner: User) {
        self.owner = owner
    }
    
    mutating func setSelectedUser(user: User) {
        selectedUsers.append(user)
    }
    
    mutating func removeAtIndex(index: Array<User>.Index) {
        selectedUsers.remove(at: index)
    }
    
    func setNewSpendToDataManaer(title: String, cost: Int) {
        let newSpend = Spend(title: title, amount: cost, owner: owner, users: selectedUsers, event: selectedEvent)
        DataManager.shared.setNew(spend: newSpend)
    }
    
    mutating func resetContent() {
        selectedUsers = []
        selectedEvent = Event(title: "Unknown")
        owner = User(name: "Unknown")
    }
}
