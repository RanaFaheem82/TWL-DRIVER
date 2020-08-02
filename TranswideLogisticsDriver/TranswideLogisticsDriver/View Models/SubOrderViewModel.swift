import Foundation
import Alamofire
import SwiftyJSON

class SubOrderViewModel {
   
    var id : Int
    var orderId : Int
    var supplierId: Int
    var subOrderStatus: String
    var status : Int
    var updatedAt: String
    var createdAt: String
    var supplier: SupplierViewModel?
    var supplierOrder : SupplierOrderListViewModel?
 
  
    
    init()
    {
        self.id = 0
        self.orderId = 0
        self.supplierId = 0
        self.subOrderStatus = ""
        self.status = 0
        self.updatedAt = ""
        self.createdAt = ""
        self.supplier = SupplierViewModel()
        self.supplierOrder = SupplierOrderListViewModel()
       
        
    }
    
    init(data: JSON){
        self.id = data["id"].intValue
        self.orderId = data["order_id"].intValue
        self.supplierId = data["supplier_id"].intValue
        self.subOrderStatus = data["sub_order_status"].stringValue
        self.status = data["status"].intValue
        self.updatedAt = data["updated_at"].stringValue
        self.createdAt = data["created_at"].stringValue
        self.supplier = SupplierViewModel(data: data["supplier"])
        self.supplierOrder = SupplierOrderListViewModel(list: data["supplier_order"])
        
    }
}
