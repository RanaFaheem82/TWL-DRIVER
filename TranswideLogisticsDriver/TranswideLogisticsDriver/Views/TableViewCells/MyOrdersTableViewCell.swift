//
//  MyOrdersTableViewCell.swift
//  Tawrid
//
//  Created by apple on 2/25/20.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class MyOrdersTableViewCell: BaseTableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionDelete(_ sender: Any) {
    }
    
    func configureView(order : OrderDetailsViewModel){
        self.setImageWithUrl(imageView: self.imgProfile, url: Global.shared.user!.image, placeholder: AssetNames.oval)
        self.lblTotalAmount.text = order.amount
        self.lblDate.text = "Date: " + self.convertDateFormatter(date: order.createdAt)
        self.lblTime.text = "Time: " + self.convertTimeFormatter(date: order.createdAt)
        
    }
  
    
}
