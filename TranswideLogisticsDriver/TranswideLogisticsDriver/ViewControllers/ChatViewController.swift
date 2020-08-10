//
//  ChatViewController.swift
//  TranswideLogisticsUser
//
//  Created by apple on 6/22/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChatViewController: BaseViewController {
    
     var chatList : [ChatViewModel] = [ChatViewModel]()
       var userId : String = ""
       var otherUserId : String = ""
       var id : String = ""
    @IBOutlet weak var txfMessage: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("chats").child(Global.shared.user!.driverId).child(self.otherUserId).observe(.childAdded, with: { (snap) in
        
        if snap.exists() {
                    let ch = snap.value as! [String: Any]
                    let mess = ch["message"] as? String
                    let id = ch["id"] as? String
                    self.chatList.append(ChatViewModel(message: mess!, sender: id!))
                }
               self.tableView.reloadData()
                 let indexPath = IndexPath(row: self.chatList.count - 1, section: 0)
                 self.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom , animated: false)
            })
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSendMessage(_ sender: Any) {
        if(self.txfMessage.text == ""){
              
           }
           else{
               
            let chat = ["message": self.txfMessage.text!, "id": Global.shared.user!.driverId] as [String: Any]
               Database.database().reference().child("chats").child(Global.shared.user!.driverId).child(self.otherUserId).childByAutoId().setValue(chat)
               
               Database.database().reference().child("chats").child(self.otherUserId).child(Global.shared.user!.driverId).childByAutoId().setValue(chat)
               
               self.txfMessage.text?.removeAll()
           }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK :-
extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return self.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if(self.chatList[indexPath.row].sender == Global.shared.user!.driverId){
                   let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableViewCell", for: indexPath) as! SenderTableViewCell
                   cell.lblMessageSend.text = self.chatList[indexPath.row].message
                   return cell
               }
               else{
                  let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                  cell.lblMessageReceived.text = self.chatList[indexPath.row].message
                  return cell
               }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
 
    
}
