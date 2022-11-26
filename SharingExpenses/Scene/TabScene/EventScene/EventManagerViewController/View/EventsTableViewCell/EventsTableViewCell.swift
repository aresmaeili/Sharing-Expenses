//
//  EventsTableViewCell.swift
//  SharingExpenses
//
//  Created by Alireza on 8/6/1401 AP.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

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

extension EventsTableViewCell {
    func configureCell(event: Event) {
        costLabel.text = event.totalSpend.description
        userCountLabel.text = event.usersCount.description
        titleLabel.text = event.title
    }
}
