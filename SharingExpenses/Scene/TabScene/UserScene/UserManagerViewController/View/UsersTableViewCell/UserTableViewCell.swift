//
//  UserTableViewCell.swift
//  SharingExpenses
//
//  Created by Alireza on 8/10/1401 AP.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var userCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UserTableViewCell {
    func configureCell(user: User) {
        titleLabel.text = user.name
        userCountLabel.text = user.eventsCount.description
        costLabel.text = user.totalOwn.toGet.description + " /  " + user.totalOwn.notOwner.description
    }
}
