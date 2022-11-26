//
//  UserModel.swift
//  SharingExpenses
//
//  Created by Alireza on 8/17/1401 AP.
//

import Foundation

struct User: Equatable {
    private(set) var id: Int
    var name: String
    var phone: String?
    
    init(name: String, phone: String = "") {
        self.id = UUID().hashValue
        self.name = name
    }
}

extension User {
    var eventsList: Events {
        var eve: Events = []
        for spend in DataManager.shared.spends {
            
            let spendd = spend.users.compactMap({$0.id})
            if spendd.contains(id) {
                eve.append(spend.event)
            }
        }
        return eve
    }
    
    var eventsCount: Int {
        eventsList.count
    }

    var own: (owner: Spends, notOwner: Spends) {
        let owner = DataManager.shared.spends.filter({$0.owner.id == id})
        let notOwner = DataManager.shared.spends.filter({($0.users.compactMap({$0.id}).contains(id))}).filter({$0.owner.id != id})
        return (owner, notOwner)
    }
    
    var totalOwn: (owner: Int, toGet: Int, notOwner: Int) {
        let ownn = own.owner.reduce(0, {$0+$1.amount})
        let toSelf = own.owner.reduce(0, {$0+($1.amount/$1.users.count)})
        let toGet = ownn - toSelf
        let notOwn = own.notOwner.reduce(0, {$0+($1.amount/$1.users.count)})
        return (ownn, toGet, notOwn)
    }
}
