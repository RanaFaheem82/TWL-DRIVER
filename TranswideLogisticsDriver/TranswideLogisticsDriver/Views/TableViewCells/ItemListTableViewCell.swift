//
//  ItemListTableViewCell.swift
//  Tawrid
//
//  Created by Rizwan Ali on 23/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class ItemListTableViewCell: BaseTableViewCell{
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    weak var delegate : ItemListTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.View.dropShadow(radius: 2, opacity: 0.2)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    func configureView(item: ProductViewModel){
        self.setImageWithUrl(imageView: self.imgImage!, url: item.image, placeholder: AssetNames.oval)
      //  self.setImageWithUrl(imageView:  self.imgImage!, url: item.image)
        self.lblName.text = item.name
        self.lblQuantity.text = "\(item.quantity)"
        self.lblPrice.text = "\(item.price)$"
        self.lblWeight.text = "\(item.quantity)\(item.type)"
        //    self.lblQuantity.text = "\(item.quantity)"
    }
    func configureSubOrderView(order: SupplierOrderViewModel){
//        if(order.image == ""){
//        }
//        else{
//            self.setImageWithUrl(imageView:  self.imgImage!, url: order.image)
//        }
        self.setImageWithUrl(imageView: self.imgImage!, url: order.image, placeholder: AssetNames.oval)
        self.lblName.text = order.productName
        self.lblWeight.text = "\(order.quantity)KG"
        self.lblPrice.text = "\(order.productPrice)$"
    }
    
    @IBAction func actionMinus(_ sender: Any) {
        if let del = self.delegate{
            del.actionMinus(cell : self)
        }
    }
    @IBAction func actionPlus(_ sender: Any) {
        if let del = self.delegate{
            del.actionPlus(cell : self)
        }
    }
    
    @IBAction func actionDelete(_ sender: Any) {
        if let del = self.delegate{
            del.actionDelete(cell : self)
        }
    }
    
    
}
