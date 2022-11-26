import Foundation

typealias Users = [User]
typealias Events = [Event]
typealias Spends = [Spend]
typealias Debt = (cost: Int, spends: Int)

// ------ table -----------
var users: Users = Users()
var events: Events = Events()
var spends: Spends = Spends()

struct User {
    private(set) var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}

extension User {
    var eventsCount: Int {
        return events.filter({$0.id == self.id}).count
    }
}

struct Event {
    private(set) var id: Int
    var title: String
    
    init(id: Int, title: String, users: [User] = []) {
        self.id = id
        self.title = title
    }
}

extension Event {
    
    //    mutating func addUser(users: User...) {
    //        self.users.append(contentsOf: users)
    //        events.updateEvent(self)
    //    }
    
    var usersCount: Int {
        users.count
    }
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
}

extension Events {
    mutating func updateEvent(_ event: Event) {
        if let i = self.firstIndex(of: event) {
            self[i] = event
        }
    }
}

struct Spend {
    private(set) var id: Int
    var title: String
    var amount: Int
    var owner: User
    var users: Users
    var event: Event
    
    init(id: Int, title: String, amount: Int, owner: User, users: [User] = [], event: Event) {
        self.id = id
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
        let filteredCosts = self.filter({$0.event.id == event.id})
        let filteredSpendsWithoutOwnerUser = filteredCosts.filter({$0.owner.id != user.id})
        let totalCost = filteredSpendsWithoutOwnerUser.reduce(0) {$0 + $1.amount}
        return totalCost/event.usersCount
    }
    
    func getEventSpend(_ event: Event, _ user: User) -> Int {
        let filteredSpends = self.filter({$0.event.id == event.id})
        let filteredSpendsByUser = filteredSpends.filter({$0.owner.id == user.id})
        let totalSpend = filteredSpendsByUser.reduce(0, {$0 + $1.amount})
        return totalSpend
    }
}

func generateID() -> Int {
    return UUID().hashValue
}

func newUser(name: String) -> User {
    let newUser = User(id: generateID(), name: name)
    users.append(newUser)
    return newUser
}

func newEvent(name: String) -> Event {
    let newEvent = Event(id: generateID(), title: name)
    events.append(newEvent)
    events.updateEvent(newEvent)
    return newEvent
}

func newSpend(title: String, amount: Int, owner: User, users: Users, event: Event) -> Spend {
    let newSpend = Spend(id: generateID(), title: title, amount: amount, owner: owner, users: users, event: event)
    spends.append(newSpend)
    return newSpend
}

let mohammad = newUser(name: "Mohammad")
let ali = newUser(name: "Ali")
let mehdi = newUser(name: "Mehdi")

var travel = newEvent(name: "travel")
var restaurant = newEvent(name: "restaurant")

events.updateEvent(travel)
events.updateEvent(restaurant)

let spend1 = newSpend( title: "خرید ماست1", amount: 5000, owner: mohammad, users: [mohammad, mehdi, ali], event: travel)
let spend2 = newSpend( title: "خرید پنیر1", amount: 2000, owner: ali, users: [mohammad, mehdi, ali], event: travel)
let spend3 = newSpend( title: "خرید نون1", amount: 3000, owner: mohammad, users: [mohammad, ali], event: travel)
let spend4 = newSpend( title: "2خرید ماست", amount: 5000, owner: mohammad, users: [mohammad, mehdi, ali], event: travel)
let spend5 = newSpend( title: "2خرید پنیر", amount: 2000, owner: ali, users: [mohammad, ali], event: restaurant)
let spend6 = newSpend( title: "2خرید نون", amount: 3000, owner: mohammad, users: [mohammad, mehdi], event: restaurant)

// spends.forEach({print($0.title)})
let mohammadTravelCost = spends.getEventCost(travel, mohammad)
let mohammadTravelSpend = spends.getEventSpend(travel, mohammad)
let mohammdAccount = spends.getUserEventAcount(travel, mohammad)

let travelUsersCount = travel.usersCount
let mohammadEventsCount = mohammad.eventsCount

// each event cost
func getEventsCost() -> [(id: Int, cost: Int)] {
    typealias UsersCost = (id: Int, cost: Int)
    var eventsCost: [UsersCost] = []
    
    for event in events {
        let thisEvent = spends.filter({$0.event.id == event.id})
        let thisEventCost = thisEvent.reduce(0, {$0 + $1.amount})
        let usersDebtAndSpend: UsersDebtAndSpend = (event.id, thisEventCost)
        eventsCost.append(usersDebtAndSpend)
    }
    return eventsCost
}

// each user cost

func usersDakhloKharj() -> [(id: Int, talab: Int, bedehi: Int)] {
    typealias UsersDebtAndSpend = (id: Int, talab: Int, bedehi: Int)
    
    var usersKharj: [UsersDebtAndSpend] = []
    
    for user in users {
        var talab = 0
        var bedehi = 0
        for spend in spends {
            for userr in spend.users where user.id == userr.id {
                    if user.id == spend.owner.id {
                        //                    print("ow",spend.title,spend.amount,spend.users.compactMap({$0.name}))
                        talab += spend.amount
                        bedehi += spend.amount/spend.users.count
                    } else {
                        //                    print("us",spend.title,spend.amount,spend.users.compactMap({$0.name}))
                        bedehi += spend.amount/spend.users.count
                    }
            }
        }
        usersKharj.append((user.id, talab, bedehi))
    }
    return usersKharj
}

func getEventsSpendList(event: Event) -> Spends {
    return spends.filter({$0.event.id == event.id})
}

func getOwners(user: User) -> (owner: Spends, notOwner: Spends) {
    
    let owneer = spends.filter({$0.owner.id == user.id})
    let notOwneer = spends.filter({$0.owner.id != user.id})
    //    print(owneer.compactMap({$0.title}), "ow" , use.name)
    //    print(notOwneer.compactMap({$0.title}), "no", use.name)
    return (owneer, notOwneer)
}

func getUserEvent() -> [(user: User, events: Events)] {

    var useer: [(user: User, events: Events)] = []
    for use in users {
        let u = use
        var e: Events = []
        for spend in spends {
            let s = spend.users.compactMap({$0.id})
            if s.contains(u.id) {
                e.append(spend.event)
            }
        }
        useer.append((user: u, events: e))
    }
    return useer
}
getUserEvent()
