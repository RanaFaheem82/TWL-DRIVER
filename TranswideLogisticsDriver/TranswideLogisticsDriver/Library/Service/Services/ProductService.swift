import Foundation
import SwiftyJSON
import Alamofire

class ProductService {
    
    private var dataRequest: DataRequest?
    
    private init(){}
    
    static func shared() -> ProductService{
        return ProductService()
    }
    
    private var sessionManager: SessionManager{
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
    
    //MARK:- getFavoroteProducts Service API
    func getFavoriteProducts(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: ProductListViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.getFavouritelist
        print("Params \(params!)")
        print("URL \(completeURL)")
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token, DictKeys.accept : EndPoints.applicationJson ]
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                        
                        let data = parsedResponse.swiftyJsonData!
                        let list = ProductListViewModel(list: data["data"])
                        completion(parsedResponse.message,true,list, resType)
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false, nil, resType)
                    }else{
                        completion(parsedResponse.message,false, nil,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false, nil,nil)
                }
            })
        
    }
    
    //MARK:- getAllProducts Service API
    func getAllProducts(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: AllProductsViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.allProducts
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
        print("Params \(params!)")
        print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                        if let data = parsedResponse.swiftyJsonData  {
                            
                            let list = AllProductsViewModel(data:data["data"])
                            completion(parsedResponse.message,true,list, resType)
                        }
                        
                        
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false, nil, resType)
                    }else{
                        completion(parsedResponse.message,false, nil,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false, nil,nil)
                }
            })
        
    }
    //MARK:- getSupplierProducts Service API
       func getSupplierProducts(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: AllProductsViewModel?,_ statusType: ServiceResponseType?)->Void){
           
           let completeURL = EndPoints.BASE_URL + EndPoints.supplierProduct
           let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
           print("Params \(params!)")
           print("URL \(completeURL)")
           dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
           
           dataRequest?
               .validate(statusCode: 200...500)
               .responseJSON(completionHandler: { response in
                   switch response.result {
                   case .success(let value):
                       let json = JSON(value)
                       print(json)
                       let parsedResponse = ResponseHandler.handleResponse(json)
                       let resType = parsedResponse.serviceResponseType
                       if resType == .Success {
                           if let data = parsedResponse.swiftyJsonData  {
                               
                               let list = AllProductsViewModel(data:data["data"])
                               completion(parsedResponse.message,true,list, resType)
                           }
                           
                           
                       }else if(resType == .Expired) {
                           completion(parsedResponse.message,false, nil, resType)
                       }else{
                           completion(parsedResponse.message,false, nil,resType)
                       }
                       
                   case .failure(let error):
                       let errorMessage:String = error.localizedDescription
                       print(errorMessage)
                       completion(errorMessage, false, nil,nil)
                   }
               })
           
       }
    
    //MARK:- Add To Favourite Service API
    func AddToFavourite(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.add_favourite
        print("Params \(params!)")
        print("URL \(completeURL)")
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                        completion(parsedResponse.message,true,resType)
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false,resType)
                    }else{
                        completion(parsedResponse.message,false,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false, nil)
                }
            })
    }
    
    //MARK:- Remove From Favourite Service API
    func RemoveFromFavourite(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.remove_favourite
        print("Params \(params!)")
        print("URL \(completeURL)")
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                        completion(parsedResponse.message,true,resType)
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false,resType)
                    }else{
                        completion(parsedResponse.message,false,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false, nil)
                }
            })
    }
    //MARK:- Search Product Service API
    func SearchProducts(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: ProductListViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.searchProduct
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
        print("Params \(params!)")
        print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                        let data = parsedResponse.swiftyJsonData!
                        let list = ProductListViewModel(list: data["data"])
                        completion(parsedResponse.message,true,list, resType)
                        
                        
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false, nil, resType)
                    }else{
                        completion(parsedResponse.message,false, nil,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false, nil,nil)
                }
            })
        
    }
}
