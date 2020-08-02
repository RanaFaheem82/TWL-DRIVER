
import Foundation
import Alamofire
import SwiftyJSON

class OrderDetailsViewModel {
    
    
    var id : Int
    var address: String
    var phoneNum: String
    var amount: String
    var lat : Int
    var lng : Int
    var comment : String
    var userId : Int
    var orderStatus : String
    var status : String
    var updatedAt: String
    var createdAt: String
    var user : UserViewModel?
    
    init()
    {
        self.id = 0
        self.address = ""
        self.phoneNum = ""
        self.amount = ""
        self.lat = 0
        self.lng = 0
        self.comment = ""
        self.userId = 0
        self.orderStatus = ""
        self.status = ""
        self.updatedAt = ""
        self.createdAt = ""
        self.user = UserViewModel()

        
    }
    
    init(data: JSON){
        self.id = data["id"].intValue
        self.address = data["address"].stringValue
        self.phoneNum = data["phone_num"].stringValue
        self.amount = data["amount"].stringValue
        self.lat = data["lat"].intValue
        self.lng = data["lng"].intValue
        self.comment = data["comment"].stringValue
        self.userId = data["user_id"].intValue
        self.orderStatus = data["order_status"].stringValue
        self.status = data["status"].stringValue
        self.updatedAt = data["updated_at"].stringValue
        self.createdAt = data["created_at"].stringValue
        self.user = UserViewModel(objUser: data["user"])
    }
}

