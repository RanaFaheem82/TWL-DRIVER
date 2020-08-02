//
//  AllCategoryViewModel.swift
//  Tawrid
//
//  Created by Rizwan Ali on 16/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CategoryProductViewModel: NSObject, NSCoding{
    var image: String
    var id: Int
    var name: String
    var status: String
    //var products: [ProductViewModel
    var updated_at: String
    var created_at: String
    
    override init()
    {
        self.image = ""
        self.id = 0
        self.name = ""
        self.image = ""
        self.status = ""
        //self.products = [ProductViewModel]()
        self.updated_at = ""
        self.created_at = ""
        
    }
    
    init(data: JSON){
        self.image = data["image"].stringValue
        self.id = data["id"].intValue
        self.name = data["name"].stringValue
        self.status = data["status"].stringValue
        //self.products = [ProductViewModel]()
//        let productsArray = data["products"].arrayValue
//        for productsJson in productsArray{
//            let cat = ProductViewModel(data: productsJson)
//            products.append(cat)
       // }
        self.created_at = data["created_at"].stringValue
        self.updated_at = data["updated_at"].stringValue
    }
    
    
       func copyCategory() -> CategoryProductViewModel {
           let category = CategoryProductViewModel()
        category.id = self.id
        category.image = self.image
        category.name = self.name
        category.status = self.status
        category.created_at = self.created_at
        category.updated_at = self.updated_at
        return category
       }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.image = aDecoder.decodeObject(forKey: "image") as?  String ?? ""
        self.name = aDecoder.decodeObject(forKey: "name") as?  String ?? ""
        self.status = aDecoder.decodeObject(forKey: "status") as?  String ?? ""
        self.created_at = aDecoder.decodeObject(forKey: "created_at") as?  String ?? ""
        self.updated_at = aDecoder.decodeObject(forKey: "updated_at") as?  String ?? ""
    }
    func encode(with aCoder: NSCoder) {
          aCoder.encode(self.id, forKey: "id")
          aCoder.encode(self.image, forKey: "image")
          aCoder.encode(self.name, forKey: "name")
          aCoder.encode(self.status, forKey: "status")
          aCoder.encode(self.created_at, forKey: "created_at")
          aCoder.encode(self.updated_at, forKey: "updated_at")
      }
}


