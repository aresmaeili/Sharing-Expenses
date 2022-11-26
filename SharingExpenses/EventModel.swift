//
//  EventModel.swift
//  SharingExpenses
//
//  Created by Alireza on 8/17/1401 AP.
//

import Foundation

struct Event {
    private(set) var id: Int
    var title: String
    var users: Users
    
    init(title: String, users: [User] = []) {
        self.id = UUID().hashValue
        self.title = title
        self.users = users
    }
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Setup Data
extension Event {
    var usersList: Users {
        var use: Users = []
        for spend in DataManager.shared.spends where spend.event.id == id {
                for user in spend.users where !(use.compactMap({$0.id}).contains(user.id)) {
                        use.append(user)
                }
        }
        return use
    }
    
    var usersCount: Int {
        usersList.count
    }
    
    var spendList: Spends {
        DataManager.shared.spends.filter({$0.event.id == id})
    }
    
    var totalSpend: Int {
        spendList.reduce(0, {$0+$1.amount})
    }
}

extension Event {
    func usersDakhloKharj(spends: Spends) -> [(id: Int, talab: Int, bedehi: Int)] {
        
        typealias IdCost = (id: Int, talab: Int, bedehi: Int)
        
        var usersKharj: [IdCost] = []
        
        for user in DataManager.shared.users {
            var talab = 0
            var bedehi = 0
            for spend in spends {
                for userr in spend.users where user.id == userr.id {
                        if user.id == spend.owner.id {
                            talab += spend.amount
                            bedehi += spend.amount/spend.users.count
                        } else {
                            bedehi += spend.amount/spend.users.count
                        }
                }
            }
            usersKharj.append((user.id, talab, bedehi))
        }
        return usersKharj
    }
}

extension Events {
    
    var getEventsCost: [(id: Int, cost: Int)] {
        typealias IdCost = (id: Int, cost: Int)
        var eventsCost: [IdCost] = []
        
        for event in DataManager.shared.events {
            let thisEvent = DataManager.shared.spends.filter({$0.event.id == event.id})
            let thisEventCost = thisEvent.reduce(0, {$0 + $1.amount})
            let aaa: IdCost = (event.id, thisEventCost)
            eventsCost.append(aaa)
        }
        return eventsCost
    }
    
    func number0fRowsInSection (_ section: Int) -> Int {
        return DataManager.shared.events.count
    }
    
    func articleAtIndex (_ index: Int) -> Event {
        DataManager.shared.events[index]
    }
}
