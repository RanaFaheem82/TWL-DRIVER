//
//  FruitsCollectionViewCell.swift
//  Tawrid
//
//  Created by Rizwan Ali on 20/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
protocol FruitsCollectionViewCellDelegate: class {
    func addToCart(cell : FruitsCollectionViewCell)
}

class FruitsCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblkg: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    weak var delegate : FruitsCollectionViewCellDelegate!
    
    func configureView(product: ProductViewModel){
        self.lblName.text = product.name
        self.setImageWithUrl(imageView: self.imgImage!, url: product.image, placeholder: AssetNames.oval)
        //self.setImageWithUrl(imageView:  self.imgImage!, url: product.image)
        self.lblPrice.text = "\(product.price)$"
        self.lblkg.text = "\(product.quantity) \(product.type.uppercased())"
        self.lblStock.text = "In Stock"
    }
    
    
    @IBAction func actionAddToCart(_ sender: Any) {
        if let del = self.delegate{
            del.addToCart(cell: self)
        }
    }
}
