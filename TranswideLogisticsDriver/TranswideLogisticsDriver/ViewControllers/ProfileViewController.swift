//
//  ProfileViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 5/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var lblCnic: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()

        // Do any additional setup after loading the view.
    }
    
    func configure(){
        self.lblCnic.text = Global.shared.user!.cnic
        self.lblAddress.text = Global.shared.user!.address
        self.lblName.text = Global.shared.user!.name
        self.lblNumber.text = Global.shared.user!.phoneNumber
    }
    
    override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
             self.mainContainer?.setTitle(title: "My Profile")
             self.mainContainer?.setMenuButton()
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
