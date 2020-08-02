import Foundation
import Alamofire
import SwiftyJSON

class CartViewModel : NSObject, NSCoding{
   
    var isOpened: Bool
    var supplier : SupplierViewModel
    var productList : ProductListViewModel
 
    override init()
    {
        self.isOpened = Bool()
        self.supplier = SupplierViewModel()
        self.productList = ProductListViewModel()
    }
    
    init(isOpen : Bool ,supplier : SupplierViewModel, list : ProductViewModel){
        self.isOpened = isOpen
        self.supplier = supplier
        self.productList = ProductListViewModel(product: list)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.isOpened = aDecoder.decodeBool(forKey: "isOpened")
        self.supplier = aDecoder.decodeObject(forKey: "supplier") as! SupplierViewModel
        self.productList = aDecoder.decodeObject(forKey: "productList") as! ProductListViewModel
      
        
    }
    func encode(with aCoder: NSCoder) {
           aCoder.encode(self.isOpened, forKey: "isOpened")
           aCoder.encode(self.supplier, forKey: "supplier")
           aCoder.encode(self.productList, forKey: "productList")
       }
    
   

}
