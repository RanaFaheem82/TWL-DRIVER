import Foundation
import Alamofire
import SwiftyJSON

class ProductViewModel: NSObject, NSCoding {
    var supplier_id : Int
    var status: Int
    var updated_at: String
    var category_id: String
    var price: String
    var image: String
    var id: Int
    var name: String
    var created_at: String
    var type: String
    var Description: String
    var quantity : Int
    var is_favourite : Int
    var supplier : SupplierViewModel
    var category : CategoryProductViewModel
    var isActive : Int
   
  

    override init()
    {
        self.supplier_id = 0
        self.is_favourite = 0
        self.quantity = 0
        self.status = 0
        self.updated_at = ""
        self.category_id = ""
        self.price = ""
        self.image = ""
        self.id = 0
        self.name = ""
        self.created_at = ""
        self.type = ""
        self.Description = ""
        self.supplier = SupplierViewModel()
        self.category = CategoryProductViewModel()
        self.isActive = 0
    }
    
    init(data: JSON){
        self.status = data["status"].intValue
        self.updated_at = data["updated_at"].stringValue
        self.category_id = data["category_id"].stringValue
        self.price = data["price"].stringValue
        self.image = data["image"].stringValue
        self.id = data["id"].intValue
        self.name = data["name"].stringValue
        self.created_at = data["created_at"].stringValue
        self.type = data["type"].stringValue
        self.Description = data["description"].stringValue
        self.quantity = data["quantity"].intValue
        self.supplier_id = data["supplier_id"].intValue
        self.is_favourite = data["is_favourite"].intValue
        self.supplier = SupplierViewModel(data: data["supplier"])
        self.category = CategoryProductViewModel(data: data["category"])
        self.isActive = data["is_active"].intValue
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        
        self.status = aDecoder.decodeInteger(forKey: "status")
        self.updated_at = aDecoder.decodeObject(forKey: "updated_at") as?  String ?? ""
        self.category_id = aDecoder.decodeObject(forKey: "category_id") as?  String ?? ""
        self.price = aDecoder.decodeObject(forKey: "price") as?  String ?? ""
        self.image = aDecoder.decodeObject(forKey: "image") as?  String ?? ""
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.name = aDecoder.decodeObject(forKey: "name") as?  String ?? ""
        self.created_at = aDecoder.decodeObject(forKey: "created_at") as?  String ?? ""
        self.type = aDecoder.decodeObject(forKey: "type") as?  String ?? ""
        self.Description = aDecoder.decodeObject(forKey: "Description") as?  String ?? ""
        self.quantity = aDecoder.decodeInteger(forKey: "quantity")
        self.supplier = aDecoder.decodeObject(forKey: "supplier") as! SupplierViewModel
        self.supplier_id = aDecoder.decodeInteger(forKey: "supplier_id")
        self.is_favourite = aDecoder.decodeInteger(forKey: "is_favourite")
        self.category = aDecoder.decodeObject(forKey: "category") as! CategoryProductViewModel
        self.isActive = aDecoder.decodeInteger(forKey: "is_active")
        
        
    }
    
    
       func copyProduct() -> ProductViewModel {
           let product = ProductViewModel()
           product.status = self.status
           product.updated_at = self.updated_at
           product.category_id = self.category_id
           product.price = self.price
           product.image  = self.image
           product.id = self.id
           product.name = self.name
           product.created_at = self.created_at
           product.type = self.type
           product.Description = self.Description
           product.quantity = self.quantity
           product.is_favourite = self.is_favourite
           product.supplier_id = self.supplier_id
           product.supplier = self.supplier.copySupplier()
           product.isActive = self.isActive
           product.category = self.category.copyCategory()
          
           return product
       }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.status, forKey: "status")
        aCoder.encode(self.updated_at, forKey: "updated_at")
        aCoder.encode(self.category_id, forKey: "category_id")
        aCoder.encode(self.price, forKey: "price")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.created_at, forKey: "created_at")
        aCoder.encode(self.type, forKey: "type")
        aCoder.encode(self.Description, forKey: "description")
        aCoder.encode(self.quantity, forKey: "quantity")
        aCoder.encode(self.supplier_id, forKey: "supplier_id")
        aCoder.encode(self.supplier, forKey: "supplier")
        aCoder.encode(self.is_favourite, forKey: "is_favourite")
        aCoder.encode(self.category,forKey: "category")
        aCoder.encode(self.isActive, forKey: "is_active")
    }
}


