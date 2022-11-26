//
//  UserCollectionViewCell.swift
//  SharingExpenses
//
//  Created by Alireza on 8/10/1401 AP.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension UserCollectionViewCell {
    func configureCell(type: CollectionType, event: Event?, user: User?, selectedEvent: Event, selectedUsersId: Users, Owner: User) {
        
        switch type {
        case .events:
            guard let event else {return}
            nameLabel.text = event.title
            imageView.tintColor = getColor(event: event, selectedEvent: selectedEvent)
        case .users:
            guard let user else {return}
            nameLabel.text = user.name
            imageView.tintColor = getColor(user: user, selectedUsers: selectedUsersId)
        default:
            nameLabel.text = user?.name
            guard let user else {return}
            imageView.tintColor = getColor(user: user, owner: Owner)
        }
    }
    
    func getColor(user: User, selectedUsers: Users) -> UIColor {
        (selectedUsers.compactMap({$0.id}).contains(user.id)) ? .red : .gray
    }
    
    func getColor(user: User, owner: User) -> UIColor {
        (owner.id == user.id) ? .red : .gray
    }
    
    func getColor(event: Event, selectedEvent: Event) -> UIColor {
        (event.id == selectedEvent.id) ? .red : .gray
    }
}

// switch type{
// case .events:
//    let event =  events
//    nameLabel.text = event.title
//    if (events?.id == event.id)  {
//        imageView.tintColor = .red
//    }else{
//        imageView.tintColor = .gray
//    }
// case .owners:
//    let user = users?[indexPath.row]
//    nameLabel.text = user?.name
//    if owner?.id == user?.id {
//        imageView.tintColor = .red
//    }else{
//        imageView.tintColor = .gray
//    }
// case .users:
//    let user =  DataManager.shared.users[indexPath.row]
//    nameLabel.text = user.name
//    guard let users else {return}
//    if ((users.compactMap({$0.id}).contains(user.id)))  {
//            imageView.tintColor = .red
//        }else{
//            imageView.tintColor = .gray
//        }
// }
