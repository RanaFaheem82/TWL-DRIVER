//
//  AddVehicleViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 4/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

protocol AddVehicleViewControllerDelegate : class{
    func selectVehicle(vehicle : VehicleViewModel)
}

class AddVehicleViewController: BaseViewController {
    var vehicleList : VehicleListViewModel = VehicleListViewModel()
   var vehicleArray = ["Toyota Perius","Honda Civic","Toyotal corolla"]
    var isFromHome : Bool = false
    weak var delegate : AddVehicleViewControllerDelegate!
    
    @IBOutlet weak var btnAddVehicle: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
   var vehicleNumber = ["LED 123","LEN 305","RGB 456","IST 877"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.mainContainer?.setTitle(title: "My Vehicles")
          self.mainContainer?.setMenuButton()
        if(isFromHome){
            self.mainContainer?.setTitle(title: "Select Vehicle")
            self.btnAddVehicle.isHidden = true
        }
        else{
            self.btnAddVehicle.isHidden = false
        }
          let params : ParamsAny = ["driverId" : Global.shared.user!.driverId]
               self.getVehicle(params: params)
          
      }
    
    @IBAction func actionAddVehicle(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewVehicleViewController") as! AddNewVehicleViewController
                      self.navigationController?.pushViewController(vc, animated: true)
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

//MARK:- TableViewMethods.

extension AddVehicleViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vehicleList.vehicleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddVehicleTableViewCell", for: indexPath) as! AddVehicleTableViewCell
        cell.configureView(name: self.vehicleList.vehicleList[indexPath.row].name, number: self.vehicleList.vehicleList[indexPath.row].number , image : self.vehicleList.vehicleList[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if(isFromHome){
        if let del = self.delegate{
            del.selectVehicle(vehicle: vehicleList.vehicleList[indexPath.row])
        }
      }
    }
}

extension AddVehicleViewController{
    func getVehicle(params :  ParamsAny){
        LoginService.shared().getVehicle(params: params) { (message, success, type, list) in
            if(success){
                self.vehicleList.vehicleList.removeAll()
                self.vehicleList = list!
                self.self.tableView.reloadData()
            }
            else{
                self.showAlertView(message: "No vehicle Registered")
            }
        }
    }
}
