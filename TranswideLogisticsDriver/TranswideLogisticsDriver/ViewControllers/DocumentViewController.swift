//
//  DocumentViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 5/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class DocumentViewController: BaseViewController {
    
    
    @IBOutlet weak var imgFitness: UIImageView!
    @IBOutlet weak var imgLicense: UIImageView!
    @IBOutlet weak var imgCNIC: UIImageView!
    var isCnic : Bool = false
    var isLicense : Bool = false
    var isFitness : Bool = false
    var image : UIImage!
    var CnicImage : String = ""
    var fitnessImage : String = ""
    var LicneseImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainContainer?.setTitle(title: "Add Documents")
        self.mainContainer?.setMenuButton()
    }
    @IBAction func actionUploadCnic(_ sender: Any) {
        self.FetchProfileImage()
        self.isCnic = true
        self.isLicense = false
        self.isFitness = false
    }
    
    @IBAction func actionUploadLicense(_ sender: Any) {
        self.FetchProfileImage()
        self.isLicense = true
        self.isCnic = false
        self.isFitness = false
    }
    
    @IBAction func actionUploadFitness(_ sender: Any) {
        self.FetchProfileImage()
        self.isLicense = false
        self.isCnic = false
        self.isFitness = true
    }
    
    
    @IBAction func actionSumbit(_ sender: Any) {
        let params : ParamsAny = ["driverId" : Global.shared.user!.driverId , "driverLiscenceImage" : self.LicneseImage, "cnicImage": self.CnicImage, "fitnessCertificateImage" : self.fitnessImage]
        self.registerDocument(params: params)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]as!UIImage
        if(self.isCnic){
            self.imgCNIC.image = image
            self.image = image
        }
        else if(self.isFitness){
            self.imgFitness.image = image
            self.image = image
        }
        else{
            self.imgLicense.image = image
            self.image = image
        }
        //  self.profileImage = image
        picker.dismiss(animated: true, completion: nil)
        let params = ["" : ""]
        self.addDocumentImage(params: params)
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
extension DocumentViewController{
    func addDocumentImage(params : ParamsString){
        self.startActivity()
        GCD.async(.Background){
            LoginService.shared().uploadImage(params: params, profileImage: self.image) { (message, success, type , image) in
                GCD.async(.Main){
                    self.stopActivity()
                        if(success){
                            
                            if(image == ""){
                                self.showAlertView(message: "server not responding please uplaod image again")
                            }
                            else{
                                if(self.isFitness){
                                    self.fitnessImage = image
                                }
                                else if(self.isCnic){
                                    self.CnicImage = image
                                }
                                else{
                                    self.LicneseImage = image
                                }
                                
                                self.showAlertView(message: message)
                            }
                            //}
                        }
                        else{
                            self.showAlertView(message: "Failed to uplaod Image")
                        }
                    }
                }
            }
        }
        
        func registerDocument(params : ParamsAny){
            self.startActivity()
            GCD.async(.Background){
                LoginService.shared().registerDocument(params: params) { (message, success, type) in
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

