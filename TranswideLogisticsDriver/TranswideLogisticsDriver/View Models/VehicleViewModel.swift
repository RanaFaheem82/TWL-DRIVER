//
//  RegisterViewModel.swift
//  Tawrid
//
//  Created by Rizwan Ali on 28/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VehicleViewModel {
    var image: String
    var number: String
    var name: String
    var color : String
   
    init() {
        self.image = ""
        self.name = ""
        self.number = ""
        self.color = ""
    }
    
    init(vehicle: JSON) {
        self.image = vehicle["vehicleImage"].stringValue
        self.name = vehicle["manufacturingCompany"].stringValue
        self.number = vehicle["regNo"].stringValue
        self.color = vehicle["Color"].stringValue
      
    }
    
}
