//
//  SideMenuProfileTableViewCell.swift
//  WrestlerBlower
//
//  Created by Rapidzz Macbook on 08/10/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import UIKit

class SideMenuProfileTableViewCell: BaseTableViewCell {
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var viewUserInfo: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure()  {
        
        let user = Global.shared.user ?? UserViewModel()
        self.setImageWithUrl(imageView: self.imgProfile!, url: user.image,placeholder: "UserProfilePlaceholder")
     //   self.lblName.text = user.userName
        self.lblEmail.text = user.email
        self.viewUserInfo.isHidden = false
        
        if(DeviceType.IS_IPAD){
            self.imgProfile.layer.cornerRadius = 65
            self.imgProfile.layer.borderWidth = 8
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
