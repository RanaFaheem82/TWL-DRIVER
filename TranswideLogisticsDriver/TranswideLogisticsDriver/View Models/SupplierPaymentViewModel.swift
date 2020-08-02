
import Foundation
import Alamofire
import SwiftyJSON

class SupplierPaymentViewModel {


    var supplierID: Int
    var supplierTotal : Int

    init()
    {
        self.supplierID = -1
        self.supplierTotal = 0
    }
    init(supplierId : Int ,total : Int){
        self.supplierID = supplierId
        self.supplierTotal = total

    }
}



