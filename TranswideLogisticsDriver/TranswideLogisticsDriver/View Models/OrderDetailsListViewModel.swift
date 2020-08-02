
import Foundation
import Alamofire
import SwiftyJSON

class OrderDetailsListViewModel {
    
    var orderList: [OrderDetailsViewModel]
    
    init() {
        self.orderList = [OrderDetailsViewModel]()
    }
    
    init(list: JSON) {
        self.orderList = [OrderDetailsViewModel]()
        let results = list.array
        
        for category in results!{
            self.orderList.append(OrderDetailsViewModel(data: category))
        }
    }
}
