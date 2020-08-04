
import UIKit
import Foundation
class ChatViewModel{
    var message: String?
    var sender : String?
    
    init (message: String, sender: String){
        self.message = message
        self.sender = sender
      
    }
}
