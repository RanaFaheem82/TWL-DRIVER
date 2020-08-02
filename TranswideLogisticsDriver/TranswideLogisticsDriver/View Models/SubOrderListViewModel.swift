
import Foundation
import Alamofire
import SwiftyJSON

class SubOrderListViewModel {
    
    var orderList: [SubOrderViewModel]
    
    init() {
        self.orderList = [SubOrderViewModel]()
    }
    
    init(list: JSON) {
        self.orderList = [SubOrderViewModel]()
        let results = list["data"].array
        
        for category in results!{
            self.orderList.append(SubOrderViewModel(data: category))
        }
    }
}
