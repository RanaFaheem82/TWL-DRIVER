
import Foundation
import Alamofire
import SwiftyJSON

class VehicleListViewModel {
    
    var vehicleList: [VehicleViewModel]
    
    init() {
        self.vehicleList = [VehicleViewModel]()
    }
    
    init(list: JSON) {
        self.vehicleList = [VehicleViewModel]()
        let results = list.array
        for vehicle in results!{
            self.vehicleList.append(VehicleViewModel(vehicle: vehicle))
        }
    }
}
