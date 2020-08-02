//
//  SupplierDetailsTableViewCell.swift
//  Tawrid
//
//  Created by apple on 2/25/20.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class SupplierDetailsTableViewCell: BaseTableViewCell {

    @IBOutlet weak var lblMinimunOrder: UILabel!
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var lblOrderAmount: UILabel!
    @IBOutlet weak var lblNoOfItem: UILabel!
    @IBOutlet weak var lblSupplierName: UILabel!
    @IBOutlet weak var imgSupplier: UIImageView!
    @IBOutlet weak var lblSupplierID: UILabel!
    @IBOutlet weak var lblSupplierId: UILabel!
    weak var delegate : nameSupplierDetailsTableViewCellDelegate!
    var amount : Int = 0
    var item : Int = 0
    var section : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    @IBAction func actionSeeDetails(_ sender: Any) {
        if let del = self.delegate{
            del.actionSeeDetails(cell : self)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       self.View.dropShadow(radius: 2, opacity: 0.2)
        // Configure the view for the selected state
    }
    
    func configureView(suborder : SubOrderViewModel){
        self.amount = 0
        for order in suborder.supplierOrder!.orderList{
            self.amount = self.amount + order.productPrice
        }
        self.lblOrderAmount.text = suborder.subOrderStatus
        self.lblSupplierID.text = "\(suborder.supplierId)"
        self.lblSupplierName.text = suborder.supplier?.name
        self.lblNoOfItem.text = "\(suborder.supplierOrder?.orderList.count ?? 0)"
        self.item = (suborder.supplierOrder?.orderList.count)!

        self.setImageWithUrl(imageView: self.imgSupplier!, url: suborder.supplier!.image, placeholder: AssetNames.oval)
    }
     func configureSupplierView(orders : CartViewModel){
            self.amount = 0
        for order in orders.productList.ProductList{
            self.amount = self.amount + Int(order.price)!
            }
            self.lblOrderAmount.text = "\(self.amount)"
        self.lblMinimunOrder.text = "\(orders.supplier.minimumOrder)$"
        self.lblSupplierID.text = "\(orders.supplier.id)"
        self.lblSupplierName.text = orders.supplier.name
        self.lblNoOfItem.text = "\(orders.productList.ProductList.count)"
        self.item = (orders.productList.ProductList.count)
        self.setImageWithUrl(imageView: self.imgSupplier!, url: orders.supplier.image, placeholder: AssetNames.oval)
        }

    @IBAction func actionSupplierOrderDetails(_ sender: Any) {
        if let del = self.delegate{
            del.actionSeeSupplierDetails(cell : self , section : section ?? -1)
        }
    }
}
