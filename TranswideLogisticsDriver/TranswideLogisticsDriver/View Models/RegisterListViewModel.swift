//
//  RegisterListViewModel.swift
//  Tawrid
//
//  Created by Rizwan Ali on 28/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class RegisterListViewModel {
    var arrayRegister: [RegisterViewModel]
    
    init() {
        self.arrayRegister = [RegisterViewModel]()
    }
    
    init(list: JSON) {
        self.arrayRegister = [RegisterViewModel]()
     //  let reg = RegisterViewModel(register: list)
    }
    
}
