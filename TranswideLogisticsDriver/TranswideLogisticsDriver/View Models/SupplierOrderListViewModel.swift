//
//  CatagoryListViewModel.swift
//  Tawrid
//
//  Created by Rizwan Ali on 16/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SupplierOrderListViewModel {
    
    var orderList: [SupplierOrderViewModel]
    
    init() {
        self.orderList = [SupplierOrderViewModel]()
    }
    
    init(list: JSON) {
        self.orderList = [SupplierOrderViewModel]()
        let results = list.array
        
        for category in results!{
            self.orderList.append(SupplierOrderViewModel(data: category))
        }
    }
}
