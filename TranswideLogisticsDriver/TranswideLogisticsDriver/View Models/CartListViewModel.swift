//
//  ProductListViewModel.swift
//  Tawrid
//
//  Created by apple on 2/11/20.
//  Copyright © 2020 Rapidzz. All rights reserved.


import Foundation
import Alamofire
import SwiftyJSON

class CartListViewModel{
    var cartProduct : ProductViewModel!
    var ProductList: [CartViewModel]
    
    init() {
        self.ProductList = [CartViewModel]()
    }
    
    init(list: CartViewModel) {
        self.ProductList = [CartViewModel]()
        self.ProductList.append(list)
        
    }
    func isSupplierAlreadyAdded(SupplierId: Int,quan: Int? = 0,ProductId: Int, price : Int, product :ProductViewModel) -> Bool {
        for item in Global.shared.carts.ProductList{
            if(item.supplier.id == SupplierId){
                let isAdded = self.isProductAlreadyAdded(list: item.productList, quan: quan, ProductId: ProductId, price: price)
                if(!isAdded){
                    self.cartProduct = product.copyProduct()
                    self.cartProduct.quantity = quan!
                    self.cartProduct.price = "\(price)"
                    item.productList.ProductList.append(cartProduct)
                }
                return true
            }
        }
        return false
    }
    func isProductAlreadyAdded(list : ProductListViewModel,quan: Int? = 0,ProductId: Int, price : Int) -> Bool {
        for item in list.ProductList{
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
        let list = Global.shared.carts.ProductList
        for item in list{
            for product in item.productList.ProductList{
                totalBill = totalBill + Double(product.price)!
            }
        }
        return totalBill
    }
    
    func makePayment(){
        
    }
    func getCompleteOrder(comments:String? = "" , address : String , total : String, id : String) -> [String:AnyObject] {
          var Order = [String:AnyObject]()
          var orderList = [[String:AnyObject]]()
          for item in self.ProductList{
            for order in item.productList.ProductList{
              var product = [String:AnyObject]()
              product = ["quantity":order.quantity,"product_id":order.id,
                         "product_name":order.name,
                         "product_price": order.price,
                         "category_id":order.category_id,
                         "supplier_id" : order.supplier_id] as [String : AnyObject]
              orderList.append(product)
          }
        }
        Order = ["total_amount": Double(total) ?? 0.0,
                      "address": address,
                      "lat":"38",
                      "lng":"37",
                      "comment": comments! ,
                      "phone_num" : "12345678",
                      "transactionId" : id,
                      "orders": orderList] as [String : AnyObject]
          
          print(Order)
          return Order
      }
}


