//
//  AddVehicleTableViewCell.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 4/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class AddVehicleTableViewCell: BaseTableViewCell {

    @IBOutlet weak var lblVehicleNumber: UILabel!
    @IBOutlet weak var lblVehicleName: UILabel!
    
    @IBOutlet weak var imgVehicle: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(name : String, number: String , image : String){
        self.lblVehicleName.text = name
        self.lblVehicleNumber.text = number
        self.setImageWithUrl(imageView: self.imgVehicle, url: image)
    }

}
