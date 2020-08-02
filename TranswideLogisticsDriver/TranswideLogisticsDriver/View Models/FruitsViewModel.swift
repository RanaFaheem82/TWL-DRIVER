//
//  FruitsViewModel.swift
//  Tawrid
//
//  Created by Rizwan Ali on 20/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
class FruitsViewModel {
    var name: String
    var image: String
    var price: String
    var kg: String
    var stock: String
    
    init(title:String, picture:String, price:String, kg: String, stock:String){
        self.name = title
        self.image = picture
        self.price = price
        self.kg = kg
        self.stock = stock
        
    }
}
