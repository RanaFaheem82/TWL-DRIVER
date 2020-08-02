
import Foundation
import Alamofire
import SwiftyJSON

class SupplierListViewModel {
    
    var supplierList: [SupplierViewModel]
    
    init() {
        self.supplierList = [SupplierViewModel]()
    }
    
    init(list: JSON) {
        self.supplierList = [SupplierViewModel]()
        let results = list["data"].array
        
        for category in results!{
            self.supplierList.append(SupplierViewModel(data: category))
        }
    }
    
}
