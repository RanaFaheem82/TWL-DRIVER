//
//  SideMenuTableViewCell.swift
//  GirlsChase
//
//  Created by Rapidzz Macbook on 04/04/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: BaseTableViewCell {

    @IBOutlet weak var imgMenu:UIImageView!
    @IBOutlet weak var lblMenu:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureView(menu:[String:String]) {
        self.imgMenu.image = UIImage(named: menu["image"]!)
        self.lblMenu.text = menu["title"]
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
