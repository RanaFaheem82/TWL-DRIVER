import Foundation
import Alamofire
import SwiftyJSON

class AllProductsViewModel{

    var current_page: Int
    var data: ProductListViewModel
    var first_page_url: String
    var from: Int
    var last_page: String
    var last_page_url: String
    var next_page_url: String
    var path: String
    var per_page: String
    var prev_page_url: String
    var to : Int
    var total : Int

    
    
    init()
    {
        self.current_page = 0
        self.data = ProductListViewModel()
        self.first_page_url = ""
        self.from = 0
        self.last_page = ""
        self.last_page_url = ""
        self.next_page_url = ""
        self.path = ""
        self.per_page = ""
        self.prev_page_url = ""
        self.to = 0
        self.total = 0
        
    }
    
    init(data: JSON){
        self.current_page = data["current_page"].intValue
        self.data = ProductListViewModel(list: data["data"])
        self.first_page_url = data["first_page_url"].stringValue
        self.from = data["from"].intValue
        self.last_page = data["last_page"].stringValue
        self.last_page_url = data["last_page_url"].stringValue
        self.next_page_url = data["next_page_url"].stringValue
        self.path = data["path"].stringValue
        self.per_page = data["per_page"].stringValue
        self.prev_page_url = data["prev_page_url"].stringValue
        self.to = data["to"].intValue
        self.total = data["total"].intValue
       
    }
    
}
