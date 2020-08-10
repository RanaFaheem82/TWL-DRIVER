//
//  AddNewVehicleViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 5/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class AddNewVehicleViewController: BaseViewController {
    
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtModelYear: UITextField!
    @IBOutlet weak var txtColor: UITextField!
    @IBOutlet weak var txtRegisterationNumber: UITextField!
    
   

    @IBOutlet weak var imgCar: UIImageView!
    
    var image : UIImage!
    var vehicleImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

      

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionUploadImage(_ sender: Any) {
          self.FetchProfileImage()
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]as!UIImage
        self.imgCar.image = image
        self.image = image
        picker.dismiss(animated: true, completion: nil)
        let params = ["" : ""]
        self.addVehicleImage(params: params)
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        let params : ParamsAny = ["driverId" : Global.shared.user!.driverId , "regNo" : self.txtRegisterationNumber.text!, "vehicleImage":  self.vehicleImage, "manufacturingCompany" : self.txtCompany.text!, "modelyear" : self.txtModelYear.text! , "Color" : self.txtColor.text!]
            self.registerVehicle(params: params)
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
extension AddNewVehicleViewController{
    func addVehicleImage(params : ParamsString){
        self.startActivity()
                   GCD.async(.Background){
        LoginService.shared().uploadImage(params: params, profileImage: self.image) { (message, success, type , image) in
                       GCD.async(.Main){
                           self.stopActivity()
            if(success){
                self.vehicleImage = image
                  self.showAlertView(message: message)
            }
            else{
                self.showAlertView(message: "Failed to uplaod Image")
            }
            }
         }
        }
    }
    
    func registerVehicle(params : ParamsAny){
        self.startActivity()
                          GCD.async(.Background){
        LoginService.shared().registerVehicle(params: params) { (message, success, type) in
                    GCD.async(.Main){
                    self.stopActivity()
            if(success){
                self.showAlertView(message: message)
            }
            else{
                 self.showAlertView(message: message)
            }
          }
        }
      }
    }
}
