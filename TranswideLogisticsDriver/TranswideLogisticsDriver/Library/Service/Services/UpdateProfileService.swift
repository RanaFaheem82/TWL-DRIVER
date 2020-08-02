import Foundation
import Alamofire
import SwiftyJSON

class UpdateProfileService : BaseService{
    
    //MARK:- Shared data
    private var dataRequest:DataRequest?
    
    //MARK:- Shared Instance
    private override init() {}
    static func shared() -> UpdateProfileService {
        return UpdateProfileService()
    }
    
    fileprivate var sessionManager:SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
   
    
  
    
    
    //MARK:- Update Profile API
//    func UpdateProfile(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool)->Void){
//
//        let completeURL = EndPoints.BASE_URL + EndPoints.profileUpdate
//        print("Params \(params!)")
//        print("URL \(completeURL)")
//        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token ]
//        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
//
//        dataRequest?
//            .validate(statusCode: 200...500)
//            .responseJSON(completionHandler: { response in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    let parsedResponse = ResponseHandler.handleResponse(json)
//
//                    if parsedResponse.serviceResponseType == .Success {
//                        completion(parsedResponse.message,true)
//                    }else {
//                        completion(parsedResponse.message,false)
//                    }
//
//                case .failure(let error):
//                    let errorMessage:String = error.localizedDescription
//                    print(errorMessage)
//                    completion(errorMessage, false)
//                }
//            })
//
//    }
    func UpdateProfile(params:ParamsString, profileImage:UIImage?,completion: @escaping (_ error: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
           
           let completeURL = EndPoints.BASE_URL + EndPoints.profileUpdate
           print("Params \(params)")
           print("URL \(completeURL)")
        let headers : HTTPHeaders = ["" : ""]

           var imageDict = [String : Data]()
                  if let image = profileImage{
                     imageDict = [DictKeys.image:image.jpegData(compressionQuality: 0.8)!]
                  }
                     self.makePostAPICallWithMultipart(with: completeURL, dict: imageDict, params: params , headers: headers) { (message, success, json , resType) in
                         if success {
                         
                         }
                         completion(message,success, resType)
                     }
       }
    
    //MARK:- RESET PASSWORD API
    func ResetPassword(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.newPassword
        print("Params \(params!)")
        print("URL \(completeURL)")
//        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token ]
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                     let resType = parsedResponse.serviceResponseType
                    
                    if parsedResponse.serviceResponseType == .Success {
                        completion(parsedResponse.message,true, resType)
                    }else {
                        completion(parsedResponse.message,false, resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false, nil)
                }
            })
        
    }
    
    //MARK:- Change PASSWORD API
        func ChangePassword(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
            
            let completeURL = EndPoints.BASE_URL + EndPoints.changePassword
            print("Params \(params!)")
            print("URL \(completeURL)")
            let headers : HTTPHeaders = ["" : ""]
            dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            
            dataRequest?
                .validate(statusCode: 200...500)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let parsedResponse = ResponseHandler.handleResponse(json)
                         let resType = parsedResponse.serviceResponseType
                        
                        if parsedResponse.serviceResponseType == .Success {
                            completion(parsedResponse.message,true, resType)
                        }else {
                            completion(parsedResponse.message,false, resType)
                        }
                        
                    case .failure(let error):
                        let errorMessage:String = error.localizedDescription
                        print(errorMessage)
                        completion(errorMessage, false, nil)
                    }
                })
            
        }
        
    
}
