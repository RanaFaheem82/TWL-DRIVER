//
//  SettingsTableViewCell.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 4/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var imgMeue: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(lbl : String , image : String){
        self.lblMenu.text = lbl
        self.imgMeue.image = UIImage(named: image)
    }

}
