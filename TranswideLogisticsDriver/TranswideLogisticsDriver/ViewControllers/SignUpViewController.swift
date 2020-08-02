//
//  SignUpViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 5/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: BaseViewController {
    
    
    @IBOutlet weak var txtfLastName: UITextField!
    @IBOutlet weak var txtfMobileNumber: UITextField!
    @IBOutlet weak var txtfFirstName: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var txtfHomeAddress: UITextField!
    @IBOutlet weak var txtfCnic: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        let params : ParamsString = ["name" : self.txtfFirstName.text! + self.txtfLastName.text! , "cnic" : self.txtfCnic.text! ,"address" : self.txtfHomeAddress.text! , "phoneNumber" : self.txtfMobileNumber.text! , "fcmToken" : Global.shared.FCMToken ?? "" , "profileImg" : ""]
        self.getUserRegister(params: params)
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
//MARK:- REGISTER API

extension SignUpViewController {
    func getUserRegister(params : ParamsString){
        LoginService.shared().getuserRegister(params: params, dict: nil) { (message, success, user, response) in
            if(success){
                self.showAlertView(message: "Account Registered SuccesFully", title: ALERT_TITLE_APP_NAME, doneButtonTitle: LocalStrings.ok) { (action) in
                                           self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showAlertView(message: "Failed to register your profile please try again later")
            }
        }
    }
}
