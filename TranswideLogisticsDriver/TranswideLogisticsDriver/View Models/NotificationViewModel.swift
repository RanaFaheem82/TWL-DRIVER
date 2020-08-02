import Foundation
import Alamofire
import SwiftyJSON

class NotificationViewModel{
  
    var id: Int
    var orderId: Int
    var userId: Int
    var supplierId: Int
    var name: String
    var image: String
    var quantity: Int
    var total: Int
    var type: String
    var message: String
    var userStatus : String
    var userRating : Int
    var status: Int
    var restaurantActive: Int
    var isActive: Int
    var createdAt: String
    var updatedAt: String
    var days: Int
    
    
    init()
    {
        self.id = 0
        self.orderId = 0
        self.userId = 0
        self.supplierId = 0
        self.name = ""
        self.image = ""
        self.quantity = 0
        self.total = 0
        self.type = ""
        self.message = ""
        self.userRating = 0
        self.userStatus = ""
         self.status = 0
         self.restaurantActive = 0
         self.isActive = 0
         self.createdAt = ""
         self.updatedAt = ""
         self.days = 0
    }
    
    init(data: JSON){
        self.id = data["id"].intValue
        self.orderId = data["order_id"].intValue
        self.userId = data["user_id"].intValue
        self.name = data["name"].stringValue
        self.image = data["image"].stringValue
        self.quantity = data["quantity"].intValue
        self.total = data["total"].intValue
        self.type = data["type"].stringValue
        self.message = data["message"].stringValue
        self.userRating = data["user_rating"].intValue
        self.supplierId = data["supplier_id"].intValue
        self.status = data["status"].intValue
        self.userStatus = data["user_status"].stringValue
        self.restaurantActive = data["restaurant_active"].intValue
        self.isActive = data["is_active"].intValue
        self.createdAt = data["created_at"].stringValue
        self.updatedAt = data["updated_at"].stringValue
        self.days = data["days"].intValue
    }
    
}


