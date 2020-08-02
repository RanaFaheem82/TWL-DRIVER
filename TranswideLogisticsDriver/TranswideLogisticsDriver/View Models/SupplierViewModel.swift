
import Foundation
import Alamofire
import SwiftyJSON

class SupplierViewModel : NSObject, NSCoding{
   
    var id: Int
    var name: String
    var email: String
    var image: String
    var address: String
    var lat: Int
    var lng: Int
    var phone_num: String
    var distance : Double
    var minimumOrder :Int
    var commission :Int
  

    
    override init()
    {
       
        self.id = 0
        self.name = ""
        self.email = ""
        self.image = ""
        self.address = ""
        self.lat = 0
        self.lng = 0
        self.phone_num = ""
        self.distance = 0
        self.minimumOrder = 0
        self.commission = 0
         
        
    }
    
    init(data: JSON){
        
        self.id = data["id"].intValue
        self.name = data["name"].stringValue
        self.email = data["email"].stringValue
        self.image = data["image"].stringValue
        self.lat = data["lat"].intValue
        self.lng = data["lng"].intValue
        self.address = data["address"].stringValue
        self.phone_num = data["phone_num"].stringValue
        self.distance = data["distance"].doubleValue
        self.minimumOrder = data["minmun_order"].intValue
        self.commission = data["commission"].intValue
    }
    
    func copySupplier() -> SupplierViewModel {
              let supplier = SupplierViewModel()
        supplier.id = self.id
        supplier.name = self.name
        supplier.email = self.email
        supplier.image = self.image
        supplier.lat = self.lat
        supplier.lng = self.lng
        supplier.address = self.address
        supplier.phone_num = self.phone_num
        supplier.distance = self.distance
        supplier.minimumOrder = self.minimumOrder
        supplier.commission = self.commission
       return supplier
          }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.name = aDecoder.decodeObject(forKey: "name") as?  String ?? ""
        self.email = aDecoder.decodeObject(forKey: "email") as?  String ?? ""
        self.lat = aDecoder.decodeInteger(forKey: "lat")
        self.image = aDecoder.decodeObject(forKey: "image") as?  String ?? ""
        self.lng = aDecoder.decodeInteger(forKey: "lng")
        self.address = aDecoder.decodeObject(forKey: "address") as?  String ?? ""
        self.phone_num = aDecoder.decodeObject(forKey: "phone_num") as?  String ?? ""
        self.distance = aDecoder.decodeDouble(forKey: "distance")
        self.minimumOrder = aDecoder.decodeInteger(forKey: "minimum_order")
        self.commission = aDecoder.decodeInteger(forKey: "commission")
      
        
    }
    func encode(with aCoder: NSCoder) {
           aCoder.encode(self.id, forKey: "id")
           aCoder.encode(self.name, forKey: "name")
           aCoder.encode(self.email, forKey: "email")
           aCoder.encode(self.lat, forKey: "lat")
           aCoder.encode(self.lng, forKey: "lng")
           aCoder.encode(self.image, forKey: "image")
           aCoder.encode(self.address, forKey: "address")
           aCoder.encode(self.phone_num, forKey: "phone_num")
           aCoder.encode(self.distance, forKey: "distance")
           aCoder.encode(self.minimumOrder, forKey: "minimum_order")
           aCoder.encode(self.commission, forKey: "commission")
       }
    
}





       
