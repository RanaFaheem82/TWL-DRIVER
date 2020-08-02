//
//  FruitsListViewModel.swift
//  Tawrid
//
//  Created by Rizwan Ali on 20/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
class FruitsListViewModel {
    var fruitList: [FruitsViewModel]
    
    init(){
        self.fruitList = [FruitsViewModel]()
        
        let f1 = FruitsViewModel(title:"Orange",picture:"Orange",price:"Price    $4.0",kg: "150 Kg",stock:"in Stock")
        self.fruitList.append(f1)
        let f2 = FruitsViewModel(title:"Apple",picture:"Apple",price:"Price    $4.0",kg: "150 Kg",stock:"in Stock")
        self.fruitList.append(f2)
        let f3 = FruitsViewModel(title:"Grapes",picture:"Grapes",price:"Price    $4.0",kg: "150 Kg",stock:"in Stock")
        self.fruitList.append(f3)
        let f4 = FruitsViewModel(title:"Strawbery",picture:"Strawbery",price:"Price    $4.0",kg: "150 Kg",stock:"in Stock")
        self.fruitList.append(f4)
        let f5 = FruitsViewModel(title:"Orange",picture:"Orange",price:"Price    $4.0",kg: "150 Kg",stock:"in Stock")
        self.fruitList.append(f5)
        let f6 = FruitsViewModel(title:"Apple",picture:"Apple",price:"Price  $4.0",kg: "150 Kg",stock:"in Stock")
        self.fruitList.append(f6)
        let f7 = FruitsViewModel(title:"Grapes",picture:"Grapes",price:"Price  $4.0",kg: "150 Kg",stock:"in Stock")
        self.fruitList.append(f7)
        let f8 = FruitsViewModel(title:"Strawbery",picture:"Strawbery",price:"Price  $4.0",kg: "150 Kg",stock:"in Stock")
        self.fruitList.append(f8)
    }
    
    
}
