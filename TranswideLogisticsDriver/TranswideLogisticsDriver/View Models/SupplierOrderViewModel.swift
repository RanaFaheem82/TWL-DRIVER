
import Foundation
import Alamofire
import SwiftyJSON

class SupplierOrderViewModel {


    var type: String
    var image : String
    var id: Int
    var subOrderId: Int
    var supplierId: Int
    var productId: Int
    var productName: String
    var productPrice: Int
    var categoryId: Int
    var quantity: Int
    var subOrderStatus: String
    var status: Int
    var createdAt: String
    var updatedAt: String
    
    
    init()
    {
        self.image = ""
        self.type = ""
        self.id = 0
        self.subOrderId = 0
        self.supplierId = 0
        self.productId = 0
        self.productName = ""
        self.productPrice = 0
        self.categoryId = 0
        self.quantity = 0
        self.subOrderStatus = ""
        self.status = 0
        self.createdAt = ""
        self.updatedAt = ""
      
         
        
    }
    
    init(data: JSON){
        self.image = data["image"].stringValue
        self.type = data["type"].stringValue
        self.id = data["id"].intValue
        self.subOrderId = data["sub_order_id"].intValue
        self.supplierId = data["supplier_id"].intValue
        self.productId = data["product_id"].intValue
        self.productName = data["product_name"].stringValue
        self.productPrice = data["product_price"].intValue
        self.categoryId = data["category_id"].intValue
        self.quantity = data["quantity"].intValue
        self.subOrderStatus = data["sub_order_status"].stringValue
        self.status = data["status"].intValue
        self.createdAt = data["created_at"].stringValue
        self.updatedAt = data["updated_at"].stringValue
      
    }
}






