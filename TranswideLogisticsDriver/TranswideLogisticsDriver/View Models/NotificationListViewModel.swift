
import Foundation
import Alamofire
import SwiftyJSON

class NotificationListViewModel {
    
    var notificationList: [NotificationViewModel]
    
    init() {
        self.notificationList = [NotificationViewModel]()
    }
    
    init(list: JSON) {
        self.notificationList = [NotificationViewModel]()
        let results = list["data"].array
        
        for category in results!{
            self.notificationList.append(NotificationViewModel(data: category))
        }
    }
}
