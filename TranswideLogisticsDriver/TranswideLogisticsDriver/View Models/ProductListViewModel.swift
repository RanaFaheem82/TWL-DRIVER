//
//  ProductListViewModel.swift
//  Tawrid
//
//  Created by apple on 2/11/20.
//  Copyright © 2020 Rapidzz. All rights reserved.


import Foundation
import Alamofire
import SwiftyJSON

class ProductListViewModel : NSObject, NSCoding {
    
    var ProductList: [ProductViewModel]
    
    override init() {
        self.ProductList = [ProductViewModel]()
    }
    
    init(list: JSON) {
        self.ProductList = [ProductViewModel]()
        let results = list.arrayValue
        for product in results {
            self.ProductList.append(ProductViewModel(data: product))
        }
    }
    init(product: ProductViewModel) {
          self.ProductList = [ProductViewModel]()
              self.ProductList.append(product)
      }
    func isProductAlreadyAdded(quan: Int? = 0,ProductId: Int, price : Int) -> Bool {
        for item in ProductList{
            if(item.id == ProductId){
                var finalQuantity = Int(item.quantity)
                finalQuantity = finalQuantity + quan!
                item.quantity = finalQuantity
                var finalPrice = Int(item.price)
                finalPrice = finalPrice! + price
                item.price = "\(finalPrice!)"
                
                return true
            }
        }
        return false
    }
    func getTotalBill() -> Double{
        var totalBill : Double = 0.0
        for item in self.ProductList{
               
            totalBill = totalBill + Double(item.price)!
        }
     return totalBill
    }
    
    func getCompleteOrder(comments:String? = "" , address : String , total : String) -> [String:AnyObject] {
        var Order = [String:AnyObject]()
        var orderList = [[String:AnyObject]]()
        for item in self.ProductList{
            var product = [String:AnyObject]()
            product = ["quantity":item.quantity,"product_id":item.id,
                       "product_name":item.name,
                       "product_price": item.price,
                       "category_id":item.category_id,
                       "supplier_id" : item.supplier_id] as [String : AnyObject]
            orderList.append(product)
        }
        Order = ["total_amount": Int(total) ?? 0,
                    "address": address,
                    "lat":"38",
                    "lng":"37",
                    "comment": comments! ,
                    "phone_num" : "12345678",
                    "orders": orderList] as [String : AnyObject]
        
        print(Order)
        return Order
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.ProductList = aDecoder.decodeObject(forKey: "ProductList") as? [ProductViewModel] ?? [ProductViewModel]()
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.ProductList, forKey: "ProductList")
    }
    
    
}



