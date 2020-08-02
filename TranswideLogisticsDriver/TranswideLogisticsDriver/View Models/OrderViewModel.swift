
import Foundation
import Alamofire
import SwiftyJSON

class OrderViewModel {
   
   
    var current: OrderDetailsListViewModel?
    var history: OrderDetailsListViewModel?
   
    init()
    {
       
        self.current = OrderDetailsListViewModel()
        self.history = OrderDetailsListViewModel()
       
         
        
    }
    
    init(data: JSON){
        self.current = OrderDetailsListViewModel(list: data["current"])
        self.history = OrderDetailsListViewModel(list: data["history"])
     
    }
}





       
