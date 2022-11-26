//
//  EventsColectionViewCell.swift
//  SharingExpenses
//
//  Created by Alireza on 8/4/1401 AP.
//

import UIKit

class EventsColectionViewCell: UICollectionViewCell {

    @IBOutlet private var parentView: UIView!
    @IBOutlet private var titlesStackView: UIStackView!
    @IBOutlet private var amountsStackView: UIStackView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        parentView.layer.cornerRadius = 20
        parentView.layer.borderWidth = 1
        parentView.layer.borderColor = UIColor.blue.cgColor
        
    }
    
    func configureCell(event: Event?, user: User?, type: CollectionType) {
        switch type {
        case .users:
            guard let user else { return }
            configCell(user: user)
        case .events:
            guard let event else { return }
            configCell(event: event)
        case .owner:
            guard let user else { return }
            configCell(user: user)
        }
    }
    
    func configCell(user: User) {
        titleLabel.text = user.name
        countLabel.text = user.eventsCount.description
        costLabel.text = "\(String(describing: user.totalOwn.owner.description))   \(String(describing: user.totalOwn.toGet))   \(String(describing: ((user.totalOwn.notOwner))))"
    }
    
    func configCell(event: Event) {
        titleLabel.text = event.title
        countLabel.text = event.usersCount.description
        costLabel.text = event.spendList.reduce(0, {$0 + $1.amount}).description
    }
    
    deinit {
        print("removed \(self) from memory")
    }
}
