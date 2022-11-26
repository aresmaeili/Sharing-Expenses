//
//  SpendsTableViewCell.swift
//  SharingExpenses
//
//  Created by Alireza on 8/10/1401 AP.
//

import UIKit

class SpendsTableViewCell: UITableViewCell {

    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var OwnerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        parentStackView.layer.cornerRadius = 50
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SpendsTableViewCell {
    func configureCell(spend: Spend) {
            titleLabel.text = spend.title
            costLabel.text = spend.amount.description
            userLabel.text = spend.users.count.description
            OwnerLabel.text = spend.owner.name
            eventLabel.text = spend.event.title
    }
}
