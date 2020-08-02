//
//  NearbySuppliersTableViewCell.swift
//  Tawrid
//
//  Created by apple on 3/19/20.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class NearbySuppliersTableViewCell: BaseTableViewCell {

    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgSupplier: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(supplier : SupplierViewModel){
        self.lblName.text = supplier.name
        self.lblDistance.text = String(format: "%.2f", supplier.distance) + "km"
        self.setImageWithUrl(imageView: self.imgSupplier, url: supplier.image, placeholder: AssetNames.oval)
    }

}
