//
//  DataManager.swift
//  SharingExpenses
//
//  Created by Alireza on 8/9/1401 AP.
//

import Foundation

typealias Users = [User]
typealias Events = [Event]
typealias Spends = [Spend]
typealias Debt = (cost: Int, spends: Int)

class DataManager {
    
    static var shared: DataManager = DataManager()
    private init() { }
  
    // ------ table -----------
//    TODO: change private
     private(set) var users: Users = Users()
     private(set) var events: Events = Events()
     private(set) var spends: Spends = Spends()
    
    func setNewList(events: Events) {
        self.events = (events)
    }
    
    func setNewList(users: Users) {
        self.users = (users)
    }
    
    func setNewList(spends: Spends) {
        self.spends = spends
    }
    
    func setNew(user: User) {
        users.append(user)
    }
    
    func setNew(event: Event) {
        events.append(event)
    }
    
    func setNew(spend: Spend) {
        spends.append(spend)
    }
    
    var usersCount: Int {
        users.count
    }
    
    var eventsCount: Int {
        events.count
    }
    
    var spendsCount: Int {
        spends.count
    }
    
}

extension DataManager {
    func setupData() {
        let dataManager = DataManager.shared
        let mohammad = User(name: "Mohammad")
        let ali = User(name: "Ali")
        let mehdi = User(name: "Mehdi")
        
        setNew(user: mohammad)
        setNew(user: mehdi)
        setNew(user: ali)
        
        let travel: Event = Event(title: "travel")
        let restaurant: Event = Event(title: "restaurant")
        setNew(event: travel)
        setNew(event: restaurant)
        
        let spend1 = Spend(title: "خرید ماست", amount: 6000, owner: mohammad, users: [ali, mohammad, mehdi], event: travel)
        dataManager.setNew(spend: spend1)
        let spend2 = Spend(title: "خرید پنیر", amount: 2000, owner: ali, users: [ali, mohammad], event: travel)
        dataManager.setNew(spend: spend2)
        let spend3 = Spend(title: "خرید نون", amount: 3000, owner: mohammad, users: [ali, mohammad], event: travel)
        dataManager.setNew(spend: spend3)
        let spend4 = Spend(title: "خرید ماست", amount: 5000, owner: mohammad, users: [ mohammad, mehdi], event: travel)
        dataManager.setNew(spend: spend4)
        let spend5 = Spend(title: "خرید پنیر", amount: 2000, owner: ali, users: [ali, mohammad], event: restaurant)
        dataManager.setNew(spend: spend5)
        let spend6 = Spend(title: "خرید نون", amount: 3000, owner: mohammad, users: [mohammad], event: restaurant)
        dataManager.setNew(spend: spend6)
    }
}
