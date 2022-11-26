//
//  EventsViewModel.swift
//  SharingExpenses
//
//  Created by Setare Yek on 10/24/22.
//

import Foundation

// MARK: - Protocols
protocol EventsViewModelDelegate {
    func didChange()
}

struct EventsViewModel {
    
    var isEdit: Bool = false
    var title: String = "Unknown"
    var events: Events { DataManager.shared.events }
    var users: Users { DataManager.shared.users  }
    var spends: Spends { DataManager.shared.spends }
    
    var spendsCount: Int {
        spends.count
    }
    var usersCount: Int {
        users.count
    }
    var eventsCount: Int {
        events.count
    }
    
    var eventTotalSpends: Int {
        events.getEventsCost.reduce(0, {$0+$1.cost})
    }
    
    func eventsForRow(indexPath: IndexPath) -> Event {
        events[indexPath.row]
    }
    
    func setNew(title: String) {
        DataManager.shared.setNew(event: Event(title: title))
    }
}
