//
//  SettingsViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 4/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let settingArray = ["Home","My Profile","My Vehicle","Personal Document","Logout"]
    let imageArray = ["home","profile-1","t","document","back-1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//Mark:- TableView Methods.

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.configureView(lbl: self.settingArray[indexPath.row] , image: self.imageArray[indexPath.row])
        
        return cell
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let drawer = self.navigationController?.parent as! KYDrawerController
              drawer.setDrawerState(.closed, animated: true)
              let mainVC = (drawer.mainViewController as! UINavigationController).topViewController as! MainContainerViewController
        if(indexPath.row == 0){
            mainVC.showHomeController()
        }
        else if(indexPath.row == 1){
            mainVC.showProfileController()
        }
        else if(indexPath.row == 2){
            mainVC.showAddVehicleController()
        }
        else if(indexPath.row == 3){
            mainVC.showPersonalDocumentController()
        }
        else if(indexPath.row == 4){
            self.logoutUserAccount()
        }
        
    }
    
    
}
