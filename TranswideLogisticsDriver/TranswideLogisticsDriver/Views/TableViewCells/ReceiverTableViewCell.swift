//
//  ReceiverTableViewCell.swift
//  TranswideLogisticsUser
//
//  Created by apple on 8/4/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var lblMessageReceived: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
