//
//  NotificationsTableViewCell.swift
//  Tawrid
//
//  Created by apple on 3/10/20.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

protocol NotificationsTableViewCellDelegate : class {
    func actionRating(cell : NotificationsTableViewCell)
}

class NotificationsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var imgSupplier: UIImageView!
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    weak var delegate : NotificationsTableViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
          super.prepareForReuse()
          self.delegate = nil
      }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func actionRating(_ sender: Any) {
        if let del = self.delegate{
            del.actionRating(cell : self)
        }
    }
    
    func configureView(notification: NotificationViewModel){
//        if(notification.image == ""){
//
//        }else{
//            self.setImageWithUrl(imageView:  self.imgSupplier!, url: notification.image)
//        }
        self.setImageWithUrl(imageView: self.imgSupplier!, url: notification.image, placeholder: AssetNames.oval)
        self.lblName.text = notification.name
        self.lblItems.text = "\(notification.quantity)"
        self.lblPrice.text = "\(notification.total)"
        self.lblMessage.text = notification.message
        if(notification.days == 0){
            self.lblDays?.text = "Today"
        }
        else{
        self.lblDays.text = "\(notification.days) days ago"
        }
    }
    
}
