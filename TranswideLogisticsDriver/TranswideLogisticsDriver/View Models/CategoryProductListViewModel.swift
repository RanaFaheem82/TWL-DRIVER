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

class CategoryProductListViewModel {
    var categoryList: [CategoryProductViewModel]
    
    init() {
        self.categoryList = [CategoryProductViewModel]()
    }
    init(list: JSON) {
        self.categoryList = [CategoryProductViewModel]()
        let results = list["data"].array
        
        for category in results!{
            self.categoryList.append(CategoryProductViewModel(data: category))
        }
    }
}
