
import Foundation
import SwiftyJSON
import Alamofire

class HelpService {
     
    private var dataRequest: DataRequest?
    
    private init(){}
    
    static func shared() -> HelpService{
        return HelpService()
    }
    
    
    private var sessionManager: SessionManager{
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
    
    //MARK:- Send Message Service API
    func sendMessage(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.addMessage
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
        print("Params \(params!)")
        print("URL \(completeURL)")
        print("Heder \(headers)")
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
                    completion(errorMessage, false,nil)
                }
            })
        
    }
}
