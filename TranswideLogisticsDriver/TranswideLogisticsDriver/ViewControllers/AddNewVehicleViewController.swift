//
//  AddNewVehicleViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 5/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class AddNewVehicleViewController: BaseViewController {
    
    @IBOutlet weak var modelYearTable: UITableView!
    @IBOutlet weak var companyTableView: UITableView!
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtModelYear: UITextField!
    @IBOutlet weak var txtColor: UITextField!
    @IBOutlet weak var txtRegisterationNumber: UITextField!
    @IBOutlet weak var imgCar: UIImageView!
    let companyArray = ["Toyota","Isuzu","Hyundai","Ford","Suzuki","Mercedes"]
    let modelArray = [1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020]
    var image : UIImage!
    var vehicleImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modelYearTable.isHidden = true
        self.companyTableView.isHidden = true

      

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
                   self.showAlertView(message: message, title: LocalStrings.success, doneButtonTitle: LocalStrings.ok) { (action) in
                                             self.navigationController?.popViewController(animated: true)
                                       }
            }
            else{
                 self.showAlertView(message: message)
            }
          }
        }
      }
    }
}

extension AddNewVehicleViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.modelYearTable){
            return self.modelArray.count
        }
        else{
            return self.companyArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManufaturingTableViewCell", for: indexPath) as! ManufaturingTableViewCell
    
        if(tableView == self.modelYearTable){
            cell.lblName.text = "\(self.modelArray[indexPath.row])"
            return cell
               }
               else{
           cell.lblName.text = self.companyArray[indexPath.row]
                return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == self.modelYearTable){
            self.txtModelYear.text = "\(self.modelArray[indexPath.row])"
            self.modelYearTable.isHidden = true
        }
        else{
           self.txtCompany.text = self.companyArray[indexPath.row]
            self.companyTableView.isHidden = true
        }
    }
    
    
}

extension AddNewVehicleViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == self.txtCompany){
              self.modelYearTable.isHidden = true
            self.companyTableView.isHidden = false
        }
        else if(textField == self.txtModelYear){
            self.modelYearTable.isHidden = false
            self.companyTableView.isHidden = true
        }
    }
    
}
